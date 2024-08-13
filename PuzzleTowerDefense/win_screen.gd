extends Control

 

func _ready():
	%n_shots_fired.text =  str(EndLevelStats.shots_fired)
	%n_tower_used.text  =  str(EndLevelStats.towers_placed)
	%n_overkill.text    =  str(EndLevelStats.overkill)
	%n_space_used.text  =  str(EndLevelStats.space_used)
	%n_money_spent.text =  str(EndLevelStats.money_spent)
	%avg_dmg_tower.text =  str(EndLevelStats.avg_tower_damage)


func _on_button_pressed():
	EndLevelStats.reset_data()
	queue_free()
