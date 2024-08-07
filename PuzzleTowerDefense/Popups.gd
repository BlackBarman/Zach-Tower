extends Control
class_name PopupManager


func open_popup(slot : Rect2i, data : CustomData):
	if data != null:
		set_data(data)
	
	var mouse_pos = get_viewport().get_mouse_position()
	var correction
	var padding = 4
	if mouse_pos.x <= get_viewport_rect().size.x/2:
		correction = Vector2i(slot.size.x + padding, 0)
	else:
		correction = -Vector2i(%ItemPopup.size.x + padding, 0)
 
	%ItemPopup.popup(Rect2i( slot.position + correction, %ItemPopup.size ))


func close_popup(): 
	%ItemPopup.hide()

func set_data(data : CustomData):
	%DamageTypeValue.text = data.Damage_type
	%DamageValue.text = str(data.Damage)
	pass
