extends Node
# number of enemies to spawn
var m_numberEnemies = 0
# spawn rate in turns
@export var m_spawnRatio:int = 1
# number of enemies spawned in a single burst
@export var SpawnSize:int = 1

@export var waves : Array[Wave] = []
var path : Path2D
var CurrentWave = 0

func _ready():
	for wave in waves:
		m_numberEnemies += wave.m_numberEnemies

	
func _turn_Start(TurnCounter: int):

	if (TurnCounter % m_spawnRatio > 0):
		return
	if (m_numberEnemies <= 0):
		return

	# Itera su ogni wave
	# Controlla se il turno corrente corrisponde al turno di spawn della wave
	if waves[CurrentWave].m_numberEnemies > 0:
		#print("Wave:",CurrentWave)
		# Spawnare nemici per questa wave
		for i in range(SpawnSize):
			# Crea una nuova istanza della scena nemica
			var mob = waves[CurrentWave].m_enemyScene.instantiate()
			# Scegli una posizione casuale sul percorso di spawn
			#var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
			#mob_spawn_location.progress_ratio = randf()

			# Recupera il nodo Path2D dal NodePath esportato in Wave
			path = get_node(waves[CurrentWave].path)
			if path and path is Path2D:
				path.add_child(mob)
				waves[CurrentWave].m_numberEnemies -= 1
				m_numberEnemies = m_numberEnemies - SpawnSize
				#print("mob spawned")
			# Verifica se ci sono altri nemici da spawnare
			if (m_numberEnemies <= 0):
				break
	else:
		CurrentWave += 1

	if (m_numberEnemies < 0):
		m_numberEnemies = 0
