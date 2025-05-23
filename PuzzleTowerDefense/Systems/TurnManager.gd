extends Node2D
var EnemyList = []
var TowerList: Array[BaseTower] = []
var BattleStarted = false
var TurnCounter = 0
@onready var StartButton = $"../CanvasLayer/StartBattleButton"



func _startBattle():
	BattleStarted = true
	$Timer.start()


func _processTurns():

	TurnCounter += 1
	#here we tell the level manager to spawn mobs
	get_tree().call_group("LevelManagerGroup", "_turn_Start", TurnCounter)

	#Enemy Turn
	EnemyList.clear()
	EnemyList = get_tree().get_nodes_in_group("EnemyGroup")
	for x in EnemyList:
		if x != null :
			await x._execute_Turn()
			#await get_tree().create_timer(0.05).timeout #dunno why this is here, looks wrong af

	await get_tree().process_frame #wait one framr to allow tower range signal to trigger

	#Towers always shoot after enemies
	TowerList.clear()

	for node in get_tree().get_nodes_in_group("TowerGroup"):
		var temp = node as BaseTower
		if temp != null:
			TowerList.append(temp)
	for y  in TowerList:
		if y != null:
			y._execute_Turn()
			await y.TowerTurnDone


# TODO test wheter or not is better to use await get_tree().process frame instead of timer
	if EnemyList.size() >= 0:
		$Timer.start() # a very small delay that prevents breaking


func _on_timer_timeout():
	_processTurns()
