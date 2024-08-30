extends Button

signal set_tower

#var towerSprite : Texture2D
var torre : PackedScene
var index : int


func _on_button_down():
	get_parent()._set_tower(index)

func _set_preview_image(image : Texture2D):
	$TextureRect.texture = image


