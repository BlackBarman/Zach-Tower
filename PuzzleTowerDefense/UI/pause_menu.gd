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
