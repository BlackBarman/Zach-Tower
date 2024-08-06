extends Node2D


var EnemyList = []
var TowerList = []

var BattleStarted = false
var TurnCounter = 0

@onready var StartButton = $StartBattleButton

#when an object enters the field, it is added to the proper list
func _objectEntersField(ObjectToAdd):
	pass

func _startBattle():
	BattleStarted = true
	get_tree().call_group("LevelManagerGroup", "_start_Timer")
	$Timer.start()
	


func _processTurns():
	
	TurnCounter += 1
	
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
		EnemyList[0].queue_free()
		EnemyList.remove_at(0)
	
	print(EnemyList.size())
	if EnemyList.size() > 0:
		_processTurns()
	else:
		pass
	
func _ObjectDies(ObjectToDestroy, ObjectType):
	
	if ObjectType == Enums.TurnObjects.ENEMY:
		EnemyList.erase(ObjectToDestroy)
	elif ObjectType == Enums.TurnObjects.TOWER:
		TowerList.erase(ObjectToDestroy)


func _on_start_battle_button_button_down():
	_startBattle()
	StartButton.visible = false
	
func _on_timer_timeout():
	_processTurns()
