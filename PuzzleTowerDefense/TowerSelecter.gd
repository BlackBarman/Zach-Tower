extends TextureRect
class_name TowerSelecter

@export var torre : PackedScene
signal set_tower

func _ready():
	#sick of forgetting to do that manually via the editor every single time
	connect("gui_input",_on_gui_input) 

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			emit_signal("set_tower",torre)

