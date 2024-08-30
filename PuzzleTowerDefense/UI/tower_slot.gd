extends Button


#var towerSprite : Texture2D
var torre : PackedScene
var index : int
signal set_tower

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_button_down():
	get_parent()._set_tower(index)

func _set_preview_image(image : Texture2D):
	$TextureRect.texture = image
	
	
