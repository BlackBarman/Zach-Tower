extends Control


func _ready():
	%n_shots_fired.text =  str(EndLevelStats.shots_fired)
	%n_overkill.text    =  str(EndLevelStats.overkill)
	%n_tower_used.text  =  str(EndLevelStats.towers_placed)
	%n_space_used.text  =  str(EndLevelStats.space_used)
	%n_money_spent.text =  str(EndLevelStats.money_spent)
	%avg_dmg_tower.text =  str(EndLevelStats.avg_tower_damage)
	%n_inactive_towers.text = str(EndLevelStats.inactive_towers)


func _on_button_pressed():
	EndLevelStats.reset_data()
	get_tree().change_scene_to_file("res://Levels/lv_1.tscn")



