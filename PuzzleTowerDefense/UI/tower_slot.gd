extends Button


@export var towerSprite : Texture2D
var torre : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#connect("gui_input",_on_gui_input) 



#func _on_gui_input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			#emit_signal("set_tower",torre)


func _on_button_down():
	print("button pressed")
	emit_signal("set_tower",torre)
