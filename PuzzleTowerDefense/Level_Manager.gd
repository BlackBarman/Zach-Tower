extends Node

# number of enemies to spawn
@export var m_numberEnemies = 0

@export var m_enemyScene: PackedScene

# spawn rate in seconds
@export var m_spawnRatio = 1.0

func _SetSpawnPath(a_SpawnPath):
	$SpawnPath.curve = a_SpawnPath.curve
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_timer_timeout():
	
	if (m_numberEnemies <= 0):
		return
		
	# Create a new instance of the Mob scene.
	var mob = m_enemyScene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()

	var player_position = $SpawnPath/SpawnLocation.position
	mob.initialize(player_position)

	
	# Spawn the mob by adding it to the Main scene.
	$SpawnPath.add_child(mob)
	m_numberEnemies = m_numberEnemies - 1


func _on_enemy_timer_ready():
	$EnemyTimer.wait_time = m_spawnRatio
	pass # Replace with function body.
