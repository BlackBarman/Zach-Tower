extends Control



func _ready():
	%n_shots_fired.text =  str(EndLevelStats.shots_fired)
	%n_overkill.text    =  str(EndLevelStats.overkill)
	%n_tower_used.text  =  str(EndLevelStats.towers_placed)
	%n_space_used.text  =  str(EndLevelStats.space_used)
	%n_money_spent.text =  str(EndLevelStats.money_spent)
	%avg_dmg_tower.text =  str(_retrieve_avg_towers_damage())
	_retrieve_inactive_towers()
	%n_inactive_towers.text = str(EndLevelStats.inactive_towers)

func _on_button_pressed():
	EndLevelStats.reset_data()
	queue_free()

func _retrieve_inactive_towers():
	for tower in get_tree().get_nodes_in_group("TowerGroup"):
		if tower.get_node("Weapon").active == false:
			EndLevelStats.IncrementInactiveTowers()

func _retrieve_avg_towers_damage() -> float:
	return float(EndLevelStats.tot_towers_damage) / float(get_tree().get_nodes_in_group("TowerGroup").size())
