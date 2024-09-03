extends Control
class_name PopupManager

@onready var button = %RemoveButton

var TooltipTower

func open_popup(slot : Rect2i, data : CustomData, tower : BaseTower): 
	if data != null:
		set_data(data)
	
	if tower != null:
		TooltipTower = tower
	
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

func Get_ItemPopup() -> PopupPanel:
	return %ItemPopup

#button that destroy towers
func _on_button_pressed():
	close_popup()
	AudioManager.DestroyTower.play()
	pass # Replace with function body.
