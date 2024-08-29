extends HBoxContainer
class_name TowerSelecter

@export var torri : Array[PackedScene] 
@export var tower_slot : PackedScene
@onready var turnManager = get_tree().get_nodes_in_group("TurnManagerGroup")[0]
signal set_tower

func _ready():
	size.x = size.x * torri.size()
	_set_tower_slots()
	

func _set_tower_slots():
	for i in torri:
		var towerSlot = tower_slot.instantiate()
		add_child(towerSlot)
		towerSlot.torre = i
