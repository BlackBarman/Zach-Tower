extends Node

# number of enemies to spawn
@export var m_numberEnemies = 0
#type of enemy to spawn
@export var m_enemyScene: PackedScene

# spawn rate in seconds
@export var m_spawnRatio = 1.0

@export var path : Path2D


func _on_enemy_timer_timeout():
	
	if (m_numberEnemies <= 0):
		return
		
	# Create a new instance of the Mob scene.
	var mob = m_enemyScene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	#var mob_spawn_location = path.cure
	# And give it a random offset.
	#mob_spawn_location.progress_ratio = randf()

	#commented out as they are not doing anything,select and press ctrl+k to uncomment [start]
	#var player_position = $SpawnPath/SpawnLocation.position
	#mob.initialize(player_position)
	#commented out as they are not doing anything select and press ctrl+k to uncomment [end]
	
	# Spawn the mob by adding it to the Main scene.
	path.add_child(mob)
	m_numberEnemies = m_numberEnemies - 1


func _on_enemy_timer_ready():
	$EnemyTimer.wait_time = m_spawnRatio
