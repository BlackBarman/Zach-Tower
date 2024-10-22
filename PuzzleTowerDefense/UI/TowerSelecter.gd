# TowerSelector.gd
extends HBoxContainer
class_name TowerSelector

signal set_tower

@export var tower_slot: PackedScene # The scene representing a tower slot

var tower_slots: Array[Button] = [] # Array to store the created tower slots
var tower_data_dict: Dictionary = {} # Dictionary to keep track of tower data properties

func _ready() -> void:
	# Populate the dictionary with tower data properties
	_populate_tower_data_dict()
	# Dynamically create tower slots
	_create_tower_slots()
	#makes so that the tower slots are not cramped onto one another
	size.x = size.x * tower_data_dict.size()

func _populate_tower_data_dict() -> void:
	# Access the tower_data from the singleton instance
	var tower_data_keys = TowerDataVault.tower_data.keys()
	for key in tower_data_keys:
		var data = TowerDataVault.tower_data[key]
		tower_data_dict[key] = {"data": data, "preview_image": data.preview_image} # Add other properties as needed

#send packed scene ref to tilemap, it knows which index was clicked
@warning_ignore("unused_parameter")
func _set_tower(index : int):
	emit_signal("set_tower")

func _create_tower_slots() -> void:
	for key in tower_data_dict.keys():
		var tower_slot_instance = tower_slot.instantiate() as TowerSlot
		add_child(tower_slot_instance)
		tower_slot_instance.name = key
		tower_slot_instance.tooltip_data = tower_data_dict[key]["data"]

		# Connect the button's pressed signal to the selection handler
		tower_slot_instance.pressed.connect(_on_tower_slot_pressed.bind(key))

		# Set the preview image
		tower_slot_instance._set_preview_image(tower_data_dict[key]["preview_image"])
		tower_slots.append(tower_slot_instance)

func _on_tower_slot_pressed(key: String) -> void:
	# Find the index of the selected tower in the dictionary
	var index = tower_data_dict.keys().find(key)

	# Call the non-static function correctly on the singleton instance
	TowerDataVault.set_selected_tower_index(index)
	#print("Tower selected:", key, "at index", index)

	#HACK: TowersArray was the parent node. We had to change it,
	#but it broke the references that had the Tilemap listening to
	#signals here. Used groups to make it independent from branch structure
	get_tree().call_group("Tilemap", "_set_tower")
