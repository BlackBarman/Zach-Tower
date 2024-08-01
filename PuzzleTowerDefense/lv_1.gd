extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap/Path2D/LevelManager._SetSpawnPath($TileMap/Path2D)
	pass # Replace with function body.




func _on_texture_rect_2_mouse_is_dragging_tower():
	pass # Replace with function body.
