extends Node2D

# Exported variables to set in the editor
@export var tower_scene: PackedScene
@export var tilemap: TileMap
@export var empty_tile_id: int = 0
@export var tower_tile_id: int = 1
signal tower_has_been_placed

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_position = event.position
		#place_tower(mouse_position)

func place_tower(mouse_position: Vector2):
	var cell = tilemap.local_to_map(mouse_position)
	if is_valid_cell(cell):
		if tilemap.get_cell_source_id(0,cell) == empty_tile_id:
			# Place the tower instance
			var tower = tower_scene.instantiate()
			tower.position = tilemap.map_to_local(cell)
			add_child(tower)
			
			# Update the tilemap to indicate the cell is now occupied
			tilemap.set_cell(0,cell, tower_tile_id)
			#sends signal to texture rect to disable dragging 
			emit_signal("tower_has_been_placed")

func is_valid_cell(cell: Vector2i) -> bool:
	return tilemap.get_used_rect().has_point(cell)
