extends Node2D
class_name SacredCrystal

@export var lose_screen : PackedScene
@export var win_screen  : PackedScene
var enemies_to_kill : int

func _ready():
	enemies_to_kill = %LevelManager.m_numberEnemies


func _process(_delta):
	if enemies_to_kill == 0 :
		player_won_level()


func _on_area_2d_body_entered(body):
	if body.is_in_group("EnemyCollisionsGroup"):
		AudioManager.Lose.play()
		call_deferred("player_lost_level")


func player_lost_level():
	get_tree().change_scene_to_packed(lose_screen)

#TODO maybe there is a better solution for passing data before changing screen?
func player_won_level():
	EndLevelStats.retrieve_inactive_towers()
	var n_towers = get_tree().get_nodes_in_group("TowerGroup").size()
	EndLevelStats.retrieve_avg_towers_damage(n_towers)
	get_tree().change_scene_to_packed(win_screen)


#use this signal in the future for enemies that spawn enemies
func _on_path_2d_child_entered_tree(_node):
	pass # Replace with function body.


func _on_path_2d_child_exiting_tree(node):
	if node.is_in_group("EnemyGroup"):
		enemies_to_kill -= 1

