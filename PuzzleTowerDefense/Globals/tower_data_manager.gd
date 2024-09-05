extends Node
class_name TowerDataManager


# Dictionary to hold tower data resources
var tower_data : Dictionary = {}

# Index to track the currently selected tower data
var selected_tower_index : int = -1 #no tower is selected initially

func _ready():
	# Initialize or load tower data resources here
	# Example:
	tower_data["ballista_tower"] = preload("res://Custom_Resources/Ballista_Tower_Data.tres")
	tower_data["magic_tower"] = preload("res://Custom_Resources/Magic_Tower_Data.tres")

func set_selected_tower_index(index: int):
	selected_tower_index = index

func get_selected_tower_data() -> Resource:
	if selected_tower_index >= 0 and selected_tower_index < tower_data.size():
		return tower_data.values()[selected_tower_index]
	return null

