extends TileMap
class_name PlacementTilemap
# Exported variables to set in the editor
@export var tilemap: TileMap
@export var empty_tile_id: int = 0
@export var tower_tile_id: int = 1


var tower_instance: PackedScene = null
var tower_object : BaseTower = null
var dragging = false

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if dragging:
			var mouse_position = event.position
			place_tower(mouse_position)

func _process(_delta):
	if dragging and tower_instance != null:
		#var tower := tower_instance as Tower
		tower_object.global_position = get_global_mouse_position()

func place_tower(mouse_position: Vector2):
	var cell = tilemap.local_to_map(mouse_position)
	if is_valid_cell(cell) :
		if tilemap.get_cell_source_id(0, cell) == empty_tile_id and tower_object.can_be_placed == true:
		# Place the tower instance on the ground , romoving it from  the mouse
		# you picked something from the crate and now you are placing it on the floor
			tower_object.global_position = tilemap.map_to_local(cell)
		# Update the tilemap to indicate the cell is now occupied
			tilemap.set_cell(0, cell, tower_tile_id)
		
		# Reset dragging state
			dragging = false
			tower_instance = null

func is_valid_cell(cell: Vector2i) -> bool:
	return tilemap.get_used_rect().has_point(cell) 

func _set_tower(tower):
	tower_instance = tower
	tower_object = tower_instance.instantiate()
	add_child(tower_object)
	dragging = true


func _on_tower_selecter_set_tower(tower):
	_set_tower(tower)
	pass # Replace with function body.
