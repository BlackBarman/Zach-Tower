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
var enemies_to_spawn


func _ready():
	for wave in waves:
		m_numberEnemies += wave.m_numberEnemies
	if waves.size() > 0:
		enemies_to_spawn = waves[CurrentWave].m_numberEnemies


func _turn_Start(TurnCounter: int):

	if (TurnCounter % m_spawnRatio > 0):
		return
	if (m_numberEnemies <= 0):
		return

	# Itera su ogni wave
	# Controlla se il turno corrente corrisponde al turno di spawn della wave
	if  enemies_to_spawn > 0:

		# Spawnare nemici per questa wave
		for i in range(SpawnSize):
			# Crea una nuova istanza della scena nemica
			var mob = waves[CurrentWave].m_enemyScene.instantiate()

			# Recupera il nodo Path2D dal NodePath esportato in Wave
			path = get_node(waves[CurrentWave].path)
			if path and path is Path2D:
				path.add_child(mob)
				enemies_to_spawn = enemies_to_spawn - SpawnSize

				m_numberEnemies = m_numberEnemies - SpawnSize
			# Verifica se ci sono altri nemici da spawnare
			if (m_numberEnemies <= 0):
				break
	else:
		CurrentWave += 1
		enemies_to_spawn = waves[CurrentWave].m_numberEnemies

	if (m_numberEnemies < 0):
		m_numberEnemies = 0
