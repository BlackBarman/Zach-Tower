extends Button
class_name  TowerSlot


#use this data to make a tooltip, data is passed correctly
var tooltip_data : CustomData


func _set_preview_image(image: Texture2D) -> void:
	$TextureRect.texture = image


func _on_mouse_entered():
	$Timer.start()


func _on_mouse_exited():
	$Timer.stop()
	%Label.hide()
	%Panel.hide()


func _on_timer_timeout():
	#+ "\n" = vai a capo +\= lo statement continua su prossima riga
	var tower_variables = "Damage: " + str(tooltip_data.Damage) + "\n" + \
		"Damage Type: " +str(tooltip_data.Damage_type) + "\n" + \
		"Fire Rate: " + str(tooltip_data.fire_rate) + "\n" + \
		"Cost: " + str(tooltip_data.cost)
	%Panel.show()
	var panelPosition = Vector2(get_local_mouse_position().x, get_local_mouse_position().y-%Panel.size.y)
	%Panel.set_position(panelPosition)
	%Label.text = tower_variables
	%Label.show()

