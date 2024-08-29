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
	var index = 0
	for i in torri:
		var towerSlot = tower_slot.instantiate()
		add_child(towerSlot)
		towerSlot.index = index
		var tempTower = i.instantiate()
		towerSlot._set_preview_image(tempTower.previewImage)
		tempTower.queue_free()
		index += 1

func _set_tower(index : int):
	var tower = torri[index]
	emit_signal("set_tower",tower)
