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
		if x == null:
			print("one of the enemies is fucked")
		print("the enemies act")
		await x._execute_Turn()
		#print("enemy acted")

	#print("inserire frase ad effetto")

	#Towers always shoot after enemies
	TowerList.clear()
	TowerList = get_tree().get_nodes_in_group("TowerGroup")
	for y in TowerList:
		print("Tower acts")
		await y._execute_Turn()

	print("tutte le torri hanno finito")	

	var EnemyWaiting = get_tree().get_nodes_in_group("LevelManagerGroup")[0].m_numberEnemies
	if EnemyList.size() > 0 || EnemyWaiting > 0:
		#print("enemies still alive")
		$Timer.start()
		#_processTurns()
	else:
		#print("all enemies defeated")
		pass

func _on_start_battle_button_button_down():
	_startBattle()
	StartButton.visible = false



func _on_timer_timeout():
	_processTurns() # Replace with function body.
