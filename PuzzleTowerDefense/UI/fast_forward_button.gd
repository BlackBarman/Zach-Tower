extends Button

func _on_toggled(toggled_on : bool) -> void:
	print(str(toggled_on))
	if toggled_on :
		Engine.time_scale = 2
	elif not toggled_on:
		Engine.time_scale = 1


#
#func _on_button_pressed() -> void:
	## Cycle Engine.time_scale from 1 to 4, then wrap back to 1
	#Engine.time_scale = (int(Engine.time_scale) % 4) + 1
