extends Node

# number of enemies to spawn
@export var m_numberEnemies = 0
#type of enemy to spawn
@export var m_enemyScene: PackedScene

# spawn rate in turns
@export var m_spawnRatio:int = 1

# number of enemies spawned in a single burst
@export var SpawnSize:int = 1

func _SetSpawnPath(a_SpawnPath):
	$SpawnPath.curve = a_SpawnPath.curve
	pass

	
func _turn_Start(TurnCounter: int):
	
	if (TurnCounter % m_spawnRatio > 0):
		return

	if (m_numberEnemies <= 0):
		return
	
	for i in SpawnSize:
		# Create a new instance of the Mob scene.
		var mob = m_enemyScene.instantiate()

		# Choose a random location on the SpawnPath.
		# We store the reference to the SpawnLocation node.
		var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
		# And give it a random offset.
		mob_spawn_location.progress_ratio = randf()
		
		#commented out as they are not doing anything,select and press ctrl+k to uncomment [start]
		#var player_position = $SpawnPath/SpawnLocation.position
		#mob.initialize(player_position)
		#commented out as they are not doing anything select and press ctrl+k to uncomment [end]
		
		# Spawn the mob by adding it to the Main scene.
		$SpawnPath.add_child(mob)
		
	
	m_numberEnemies = m_numberEnemies - SpawnSize
	if (m_numberEnemies < 0):
		m_numberEnemies = 0

