extends VBoxContainer

@onready var levelManagerRef = get_tree().get_first_node_in_group("LevelManagerGroup")

var totalEnemies = 0
var enemiesKilled = 0
var enemyTypes = []

func _ready():
	#await levelManagerRef # not needed
	EndLevelStats.enemyKilled.connect(_update_enemies_killed)
	_collect_Data()
	_update_Text()

#prepare all the data like the total number of enemies,
#the enemy types, etc.
func _collect_Data():
	for wave in levelManagerRef.waves:
		totalEnemies += wave.m_numberEnemies
		var enemy = wave.m_enemyScene.instantiate()
		
		if (!enemyTypes.has(enemy.enemyName)):
			enemyTypes.append(enemy.enemyName)
		enemy.queue_free()

func _update_enemies_killed():
	enemiesKilled += 1
	_update_Text()

#actually changes the text
func _update_Text():

	$Info.text = "Total Enemies: " + str(totalEnemies) + "\n" + \
	"Enemies Killed: " + str(enemiesKilled) + "\n" + \
	"Enemy Types: " + "\n" + \
	"\n".join(enemyTypes)

