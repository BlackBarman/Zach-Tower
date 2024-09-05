extends Node2D
class_name SacredCrystal

@export var lose_screen : PackedScene
@export var win_screen  : PackedScene
@onready var enemies_to_kill = %LevelManager.m_numberEnemies


func _on_area_2d_body_entered(body):
	if body.is_in_group("EnemyCollisionsGroup"):
		var x = lose_screen.instantiate()
		AudioManager.Lose.play()
		get_tree().root.add_child(x)

func player_won_level():
	var x = win_screen.instantiate()
	get_tree().root.add_child(x)

func Check_WinCondition():
	enemies_to_kill -= 1
	if enemies_to_kill == 0:
		player_won_level()


