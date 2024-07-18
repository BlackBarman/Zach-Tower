extends ItemList

@export var default_level : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#start playing
	if is_selected(0):
		get_tree().change_scene_to_packed(default_level)
	
	#quit game
	if is_selected(3):
		get_tree().quit()
	
