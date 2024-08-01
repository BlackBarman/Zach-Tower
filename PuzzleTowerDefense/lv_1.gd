extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap/Path2D/LevelManager._SetSpawnPath($TileMap/Path2D)
	pass # Replace with function body.


