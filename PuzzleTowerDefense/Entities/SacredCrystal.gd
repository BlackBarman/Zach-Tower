extends Node2D
class_name SacredCrystal

@export var lose_screen : PackedScene
@export var win_screen  : PackedScene

func _on_area_2d_body_entered(body):
	if body.is_in_group("EnemyCollisionsGroup"):
		#var x = lose_screen.instantiate()
		AudioManager.Lose.play()
		call_deferred("player_lost_level")
		#player_lost_level()

func player_lost_level():
	get_tree().change_scene_to_packed(lose_screen)

func player_won_level():
	print("player won levl changing screen")
	get_tree().change_scene_to_packed(win_screen)



