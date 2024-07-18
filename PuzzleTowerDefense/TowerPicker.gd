extends TextureRect

@export var Tower: PackedScene

var tower_instance: Node = null
var dragging: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if dragging and tower_instance:
		tower_instance.global_position = get_global_mouse_position()

func _on_gui_input(event):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				print("Left mouse button pressed")
				if not tower_instance:
					tower_instance = Tower.instantiate()
					get_tree().root.add_child(tower_instance)
					tower_instance.global_position = get_global_mouse_position()
				dragging = true
			#elif event.release:
				#print("Left mouse button released")
				#dragging = false


func _on_tile_map_tower_has_been_placed():
	if dragging == true :
		tower_instance.queue_free()
		dragging = false
	pass # Replace with function body.
