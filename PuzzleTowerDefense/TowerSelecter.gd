extends TextureRect
class_name TowerSelecter

@export var torre : PackedScene
signal set_tower

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			emit_signal("set_tower",torre)

