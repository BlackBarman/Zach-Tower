extends Node

class_name  DisplayRangeComponent

@export var AttackRange = 1
var ShowPreview = true
@export var tilemap: TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	#tilemap = find_tilemap()
	#if tilemap == null:
		#print("TileMap non trovata nella scena principale")
	#else:
		#print("TileMap trovata:", tilemap)
	pass # Replace with function body.

func _Setupfunc( a_tilemap: TileMap):
	tilemap = a_tilemap
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ShowPreview == true:
		var parent_node = get_parent()
		#var cell = tilemap.local_to_map(parent_node.global_position)
		#_Range_Preview(cell)
	pass


func _Range_Preview(cell: Vector2i):

<<<<<<< Updated upstream
	if tilemap.get_cell_tile_data(0,cell).get_custom_data("EmptyTile") == true:
		tilemap.set_cell(1,cell,1, Vector2i(0,0),0)
=======
	# Add tiles to highlight
	for tile in reachable_tiles:
		if is_in_bounds(tile):
			if not highlighted_tiles.has(tile):
				var atlas_coord = tilemap.get_cell_atlas_coords(0, tile)
				highlight_tile(tile)
				highlighted_tiles[tile] = atlas_coord

	# Remove highlighted tiles outside range
	for tile in highlighted_tiles.keys():
		if tile not in reachable_tiles:
			tiles_to_remove.append([tile, highlighted_tiles[tile]])

	for tile_atlas in tiles_to_remove:
		var tile = tile_atlas[0]
		var atlas_coord = tile_atlas[1]
		if is_in_bounds(tile):
			tilemap.set_cell(1, tile, 0, atlas_coord, 0)  # Ripristina il tile originale
		highlighted_tiles.erase(tile)

func _Clear_Highlighted_Tiles():
	# Restore all highlighted tiles to their original state
	for tile in highlighted_tiles.keys():
		var atlas_coord = highlighted_tiles[tile]
		if is_in_bounds(tile):
			tilemap.set_cell(1, tile, 0, atlas_coord, 0)
	highlighted_tiles.clear()

func get_reachable_tiles(start: Vector2i) -> Array:
	var reachable_tiles = []
	for direction in active_directions:
		var dir_vector = directions[direction]
		for r in range(1, AttackRange + 1):
			var reachable_tile = Vector2i(start.x + dir_vector.x * r, start.y + dir_vector.y * r)
			if is_in_bounds(reachable_tile):
				reachable_tiles.append(reachable_tile)
	return reachable_tiles

func is_in_bounds(tile: Vector2i) -> bool:
	var map_size = tilemap.get_used_rect()
	return tile.x >= map_size.position.x and tile.x < map_size.position.x + map_size.size.x and tile.y >= map_size.position.y and tile.y < map_size.position.y + map_size.size.y

func highlight_tile(tile: Vector2i):
	pass
	#if is_in_bounds(tile) and tilemap is TileMap:
		#tilemap.set_cell(1, tile, green_tile_id, Vector2i(0,0))
>>>>>>> Stashed changes

func find_tilemap() -> TileMap:
	var current_node = self
	while current_node:
		if current_node.has_node("TileMap"):
			return current_node.get_node("TileMap")
		current_node = current_node.get_parent()
	return null
