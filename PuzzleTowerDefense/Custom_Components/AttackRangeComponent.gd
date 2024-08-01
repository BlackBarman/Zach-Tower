extends Node

class_name DisplayRangeComponent

@export var AttackRange = 3
var ShowPreview = true
@export var green_tile_id: int = 1  # ID del tile per evidenziare l'area
@export var default_tile_id: int = 0  # ID del tile di default
@export var tilemap: TileMap

@export var directions = {
	"N": Vector2i(0, -1),
	"NE": Vector2i(1, -1),
	"E": Vector2i(1, 0),
	"SE": Vector2i(1, 1),
	"S": Vector2i(0, 1),
	"SW": Vector2i(-1, 1),
	"W": Vector2i(-1, 0),
	"NW": Vector2i(-1, -1)
}

@export var active_directions = ["S", "SW", "W", "N", "NE", "E", "SE", "NW"]

# Highlighted tiles
var highlighted_tiles: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap = find_tilemap()
	if tilemap == null:
		print("TileMap non trovata nella scena principale")
	else:
		print("TileMap trovata:", tilemap)

func _Setupfunc(a_tilemap: TileMap):
	tilemap = a_tilemap

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if tilemap == null:
		return

	if ShowPreview:
		var parent_node = get_parent()
		var cell = tilemap.local_to_map(parent_node.global_position)
		_Range_Preview(cell)
	else:
		_Clear_Highlighted_Tiles()

func _Range_Preview(cell: Vector2i):
	var reachable_tiles = get_reachable_tiles(cell)
	var tiles_to_remove = []

	# Add tiles to highlight
	for tile in reachable_tiles:
		if is_in_bounds(tile):
			if not highlighted_tiles.has(tile):
				highlight_tile(tile)
				highlighted_tiles[tile] = tilemap.get_cell_atlas_coords(0, tile)

	# Remove highlighted tiles outside range
	for tile in highlighted_tiles.keys():
		if tile not in reachable_tiles:
			tiles_to_remove.append([tile, highlighted_tiles[tile]])

	for tile_atlas in tiles_to_remove:
		var tile = tile_atlas[0]
		var atlas_coord = tile_atlas[1]
		tilemap.set_cell(1, tile, 0, atlas_coord, 0)
		highlighted_tiles.erase(tile)

func _Clear_Highlighted_Tiles():
	# Restore all highlighted tiles to the default state
	for tile in highlighted_tiles.keys():
		tilemap.set_cell(1, tile, default_tile_id, Vector2i(0,0))
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
	if tilemap is TileMap:
		tilemap.set_cell(1, tile, green_tile_id, Vector2i(0,0))

func find_tilemap() -> TileMap:
	var root = get_tree().root
	return _find_tilemap_in_node(root)

func _find_tilemap_in_node(node: Node) -> TileMap:
	if node is TileMap:
		return node as TileMap

	for child in node.get_children():
		var tilemap = _find_tilemap_in_node(child)
		if tilemap:
			return tilemap

	return null

func _Get_tile_in_range() -> Dictionary:
	return highlighted_tiles
