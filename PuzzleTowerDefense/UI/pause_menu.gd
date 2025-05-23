extends Button


func _on_pressed():
	if (!get_tree().paused):
		get_tree().paused = true
		$Panel.visible = true
	else:
		get_tree().paused = false
		$Panel.visible = false


func _on_resume_button_pressed():
	get_tree().paused = false
	$Panel.visible = false

func _on_main_menu_button_pressed():
	get_tree().paused = false
	LevelChanger._change_level("res://Levels/Screens/MainMenu.tscn")

func _on_restart_button_pressed():
	get_tree().paused = false
	EndLevelStats.reset_data()
	var LevelManagerRef = get_tree().get_first_node_in_group("LevelManagerGroup")
	LevelManagerRef.queue_free()
	get_tree().reload_current_scene()
