extends PanelContainer
class_name Tooltip

@export var data : CustomData 

var popup
var DisplayPopup = false
var hovered :bool = false

signal buttonsSignal

func _on_mouse_entered():
	hovered = true

func _on_mouse_exited():
	hovered = false

func _input(event):
	if hovered and DisplayPopup and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and data != null:
		Popups.open_popup(Rect2i(Vector2i(global_position),Vector2i(size)),data, get_parent() as BaseTower)


func _on_base_tower_active_tooltip():
	await get_tree().create_timer(0.5).timeout
	DisplayPopup = true
	pass # Replace with function body.()
