extends PanelContainer
class_name Tooltip

@export var data : CustomData 


func _on_mouse_entered():
	if data != null:
		Popups.open_popup(Rect2i(Vector2i(global_position),Vector2i(size)),data)


func _on_mouse_exited():
	Popups.close_popup()
