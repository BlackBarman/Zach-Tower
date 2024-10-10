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
	$Label.hide()


func _on_timer_timeout():
	$Label.text = str(tooltip_data.Damage)
	$Label.show()

