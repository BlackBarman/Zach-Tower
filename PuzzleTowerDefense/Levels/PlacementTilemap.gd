extends TileMap
class_name PlacementTilemap

signal tower_placed


@export var tilemap: TileMap

var tower_instance: PackedScene 
var tower_object: BaseTower = null
var dragging = false


func _ready():
	set_process_input(true)


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and not GlobalState.is_level_playing:
		if dragging:
			var mouse_position = event.position
			place_tower(mouse_position)


func _process(_delta):
	if dragging and tower_object != null:
		# Snaps the tower object position to the tile grid
		var mouse_position = get_local_mouse_position()
		var cell_position = tilemap.local_to_map(mouse_position)
		tower_object.global_position = tilemap.map_to_local(cell_position)


func place_tower(mouse_position: Vector2):
	var cell = tilemap.local_to_map(mouse_position)
	if is_valid_cell(cell) and tower_object.can_be_placed:
		# Place the tower instance on the ground, removing it from the mouse
		tower_object.global_position = tilemap.map_to_local(cell)
		# Reset dragging state
		dragging = false
		UpdateStat(tower_object)
		emit_signal("tower_placed")


func is_valid_cell(cell: Vector2i) -> bool:
	return tilemap.get_used_rect().has_point(cell)

# spawn tower passed by UI palette
func _set_tower(): 
	var tower = TowerDataVault.get_selected_tower_data() as CustomData
	tower_instance = tower.tower_scene
	tower_object = tower_instance.instantiate()
	add_child(tower_object)
	dragging = true


# function that update the endLevelStat for the win Screen
func UpdateStat(tower):
	EndLevelStats.AddSpaceUsed(tower.space_occupied) #to change with the real space occupied by tower
	EndLevelStats.IncrementTowersPlaced()
	EndLevelStats.AddMoneySpent(tower.data.cost)


# if we press start and we have tower in hand, delete the tower in hand
func _on_start_battle_button_button_down():
	if dragging == true :
		tower_object.queue_free()

