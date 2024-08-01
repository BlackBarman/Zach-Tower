extends Node2D


var EnemyList = []
var TowerList = []

var BattleStarted = false

@onready var StartButton = $StartBattleButton

#when an object enters the field, it is added to the proper list
func _objectEntersField(ObjectToAdd):
	
	if ObjectToAdd.ObjectType == Enums.TurnObjects.ENEMY:
		EnemyList.Append(ObjectToAdd)
	elif ObjectToAdd.ObjectType == Enums.TurnObjects.TOWER:
		TowerList.Append(ObjectToAdd)

func _startBattle():
	BattleStarted = true
	_processTurns()

func _processTurns():
	
	for x in EnemyList:
		x._executeTurn()
	
	#Towers always shoot after enemies
	for y in TowerList:
		y._executeTurn()
	
	if EnemyList.size() > 0:
		_processTurns()
	else:
		_cleanUpBattle()
	
func _ObjectDies(ObjectToDestroy, ObjectType):
	
	if ObjectType == Enums.TurnObjects.ENEMY:
		EnemyList.erase(ObjectToDestroy)
	elif ObjectType == Enums.TurnObjects.TOWER:
		TowerList.erase(ObjectToDestroy)
	
func _cleanUpBattle():
	
	for x in EnemyList:
		x.queue_free()
	EnemyList.clear()
	
	for y in TowerList:
		y.queue_free()
	TowerList.clear()
	
	StartButton.visible = true


func _on_start_battle_button_button_down():
	_startBattle()
	StartButton.visible = false
	
