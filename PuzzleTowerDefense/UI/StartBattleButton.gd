extends Button


func _on_button_down():
	get_tree().call_group("TurnManagerGroup", "_startBattle")
	disabled = true
	AudioManager.StartStage.play()
	GlobalState.is_level_playing = true
