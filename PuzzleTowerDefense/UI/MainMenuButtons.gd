extends ItemList

@export var default_level : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	#start playing
	if is_selected(0):
		get_tree().change_scene_to_packed(default_level)
		AudioManager.BG_Music_MainMenu.stop()
		AudioManager.BG_Music_BuildingStage.play()

	#quit game
	if is_selected(3):
		get_tree().quit()

