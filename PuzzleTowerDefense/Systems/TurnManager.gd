extends Node2D
var EnemyList = []
var TowerList = []
var BattleStarted = false
var TurnCounter = 0
@onready var StartButton = $"../CanvasLayer/StartBattleButton"



func _startBattle():
	BattleStarted = true
	$Timer.start()


func _processTurns():

	TurnCounter += 1
	get_tree().call_group("LevelManagerGroup", "_turn_Start", TurnCounter)

	#Enemy Turn
	EnemyList.clear()
	EnemyList = get_tree().get_nodes_in_group("EnemyGroup")
	for x in EnemyList:
		if x != null :
			#print("enemy turn")
			await x._execute_Turn()
			await get_tree().create_timer(0.05).timeout

	await get_tree().process_frame #waits one fram to allow tower range signal to trigger

	#Towers always shoot after enemies
	TowerList.clear()
	TowerList = get_tree().get_nodes_in_group("TowerGroup")
	for y in TowerList:
		if y != null:
			#print("tower turn")
			await y._execute_Turn()

	if EnemyList.size() > 0:
		$Timer.start() # a very small delay that prevents breaking


func _on_timer_timeout():
	_processTurns()
