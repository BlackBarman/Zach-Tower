extends ItemList

var default_level = preload("res://lv_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#start playing
	if is_selected(0):
		get_tree().change_scene_to_file("res://lv_1.tscn")
	
	#quit game
	if is_selected(3):
		get_tree().quit()
	