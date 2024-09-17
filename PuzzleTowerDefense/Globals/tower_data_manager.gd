extends Node
class_name TowerDataManager


# Dictionary to hold tower data resources
var tower_data : Dictionary = {
"ballista_tower": preload("res://Custom_Resources/Ballista_Tower_Data.tres"),
"magic_tower": preload("res://Custom_Resources/Magic_Tower_Data.tres"),
"sniper_tower":preload("res://Custom_Resources/Sniper_Tower_Data.tres"),
}

# Index to track the currently selected tower data
var selected_tower_index : int = 0 #no tower is selected initially


func set_selected_tower_index(index: int):
	selected_tower_index = index

# returns the tres file we are pointing at (should)
func get_selected_tower_data() -> Resource:
	if selected_tower_index >= 0 and selected_tower_index < tower_data.size():
		return tower_data.values()[selected_tower_index]
	return null

