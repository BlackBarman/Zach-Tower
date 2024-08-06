extends Node2D


var EnemyList = []
var TowerList = []

var BattleStarted = false
var TurnCounter = 0

@onready var StartButton = $StartBattleButton


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
		#x._executeTurn()
		print("Enemy acts")
	
	#Towers always shoot after enemies
	TowerList.clear()
	TowerList = get_tree().get_nodes_in_group("TowerGroup")
	for y in TowerList:
		#y._executeTurn()
		print("Tower acts")
		#EnemyList[0].queue_free()
		#EnemyList.remove_at(0)
	
	print("Number of enemies: " , EnemyList.size())
	var EnemyWaiting = get_tree().get_nodes_in_group("LevelManagerGroup")[0].m_numberEnemies
	if EnemyList.size() > 0 || EnemyWaiting > 0:
		#_processTurns()
		print("enemies still alive")
	else:
		print("all enemies defeated")


func _on_start_battle_button_button_down():
	_startBattle()
	StartButton.visible = false
	
func _on_timer_timeout():
	_processTurns()
