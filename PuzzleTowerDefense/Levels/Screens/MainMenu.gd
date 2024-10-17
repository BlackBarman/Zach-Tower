extends Camera2D

@onready var PressAnyButtonTemp = $PressAnyButtonTemp
@onready var ButtonList = $ItemList


func _ready():
	ButtonList.hide()
	AudioManager.BG_Music_MainMenu.play()


func _process(_delta):
	if Input.is_anything_pressed():
		#checks if the press any button temp is still childed to the camera before removing
		if PressAnyButtonTemp and PressAnyButtonTemp.get_parent() == self:
			remove_child(PressAnyButtonTemp)
		ButtonList.show()

