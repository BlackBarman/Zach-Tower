extends Node
# made by Nico

class_name  DisplayRangeComponent

@export var AttackRange = 1
var ShowPreview = true
@export var tilemap: TileMap



func _Setupfunc( a_tilemap: TileMap):
	tilemap = a_tilemap
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if ShowPreview == true:
		var parent_node = get_parent()
		#var cell = tilemap.local_to_map(parent_node.global_position)
		#_Range_Preview(cell)
	pass


func _Range_Preview(cell: Vector2i):

	if tilemap.get_cell_tile_data(0,cell).get_custom_data("EmptyTile") == true:
		tilemap.set_cell(1,cell,1, Vector2i(0,0),0)

func find_tilemap() -> TileMap:
	var current_node = self
	while current_node:
		if current_node.has_node("TileMap"):
			return current_node.get_node("TileMap")
		current_node = current_node.get_parent()
	return null
