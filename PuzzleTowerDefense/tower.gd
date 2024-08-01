extends Node2D

class_name Tower


var placed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _Set_placed(flag):
	placed = flag
	if placed == true:
		$Node2D/AnimatedSprite2D.highlighted_tiles = $DisplayRangeComponent.highlighted_tiles
		$DisplayRangeComponent.ShowPreview = false

func _on_display_range_component_2_ready():
	pass # Replace with function body.
