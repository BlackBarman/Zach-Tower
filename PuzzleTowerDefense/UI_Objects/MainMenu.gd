extends Camera2D

@onready var PressAnyButtonTemp = $PressAnyButtonTemp
@onready var ButtonList = $ItemList

# Called when the node enters the scene tree for the first time.
func _ready():
	ButtonList.hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_anything_pressed():
		remove_child(PressAnyButtonTemp)
		ButtonList.show()
