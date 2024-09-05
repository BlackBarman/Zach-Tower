extends Node



func _ready():
	var i = TowerDataVault.get_selected_tower_data() as CustomData
	print(i.Damage_type)
