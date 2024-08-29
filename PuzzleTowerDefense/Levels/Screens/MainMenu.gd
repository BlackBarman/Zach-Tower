extends Camera2D

@onready var PressAnyButtonTemp = $PressAnyButtonTemp
@onready var ButtonList = $ItemList

# Called when the node enters the scene tree for the first time.
func _ready():
	ButtonList.hide()
	AudioManager.BG_Music_MainMenu.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_anything_pressed():
		#checks if the press any button temp is still childed to the camera before removing
		if PressAnyButtonTemp and PressAnyButtonTemp.get_parent() == self:
			remove_child(PressAnyButtonTemp)
		ButtonList.show()
		

#an alternative that doen't uses the _process function
# Called whenever an input event is received.
#func _input(event):
	#if event is InputEventKey or event is InputEventMouseButton or event is InputEventJoypadButton:
		#if PressAnyButtonTemp and PressAnyButtonTemp.get_parent() == self:
			#remove_child(PressAnyButtonTemp)
		#ButtonList.show()
