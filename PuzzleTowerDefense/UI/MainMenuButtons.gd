extends ItemList


@export var first_level : String = "res://Levels/lv_1.tscn"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	#start playing
	if is_selected(0):
		LevelChanger._change_level(first_level)
		AudioManager.BG_Music_MainMenu.stop()
		AudioManager.BG_Music_BuildingStage.play()

	#quit game
	if is_selected(3):
		get_tree().quit()

