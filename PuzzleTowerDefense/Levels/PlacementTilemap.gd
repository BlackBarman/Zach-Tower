extends TileMap
class_name PlacementTilemap

# Exported variables to set in the editor
@export var tilemap: TileMap
@export var empty_tile_id: int = 0
@export var tower_tile_id: int = 1

var tower_instance: PackedScene = null
var tower_object: BaseTower = null
var dragging = false

signal tower_placed

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if dragging:
			var mouse_position = event.position
			place_tower(mouse_position)

func _process(_delta):
	if dragging and tower_instance != null:
		# Snaps the tower object position to the tile grid
		var mouse_position = get_local_mouse_position()
		var cell_position = tilemap.local_to_map(mouse_position)
		tower_object.global_position = tilemap.map_to_local(cell_position)

func place_tower(mouse_position: Vector2):
	var cell = tilemap.local_to_map(mouse_position)
	if is_valid_cell(cell):
		if tilemap.get_cell_source_id(0, cell) == empty_tile_id and tower_object.can_be_placed:
			# Place the tower instance on the ground, removing it from the mouse
			tower_object.global_position = tilemap.map_to_local(cell)
			# Update the tilemap to indicate the cell is now occupied
			tilemap.set_cell(1, cell, tower_tile_id)
			# Reset dragging state
			dragging = false
			emit_signal("tower_placed")
			tower_instance = null


func is_valid_cell(cell: Vector2i) -> bool:
	return tilemap.get_used_rect().has_point(cell)


#TODO fix this mess, we need to get the selected towerdata (wich point to a tres file)
# said tres file has a Packed scene property that we want to access
func _set_tower():
	var i = TowerDataVault.get_selected_tower_data() as CustomData
	tower_instance = i.Tower_Scene
	tower_object = tower_instance.instantiate()
	add_child(tower_object)
	dragging = true


func _on_towers_array_set_tower():
	_set_tower()
