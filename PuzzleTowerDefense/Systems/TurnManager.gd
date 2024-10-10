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
		await x._execute_Turn()

	#Towers always shoot after enemies
	TowerList.clear()
	TowerList = get_tree().get_nodes_in_group("TowerGroup")
	for y in TowerList:
		await y._execute_Turn()

	var EnemyWaiting = get_tree().get_nodes_in_group("LevelManagerGroup")[0].m_numberEnemies
	if EnemyList.size() > 0 || EnemyWaiting > 0:
		$Timer.start()
	else:
		%SacredCrystal.player_won_level()

func _on_start_battle_button_button_down():
	_startBattle()
	StartButton.visible = false
	AudioManager.StartStage.play()

func _on_timer_timeout():
	_processTurns()
