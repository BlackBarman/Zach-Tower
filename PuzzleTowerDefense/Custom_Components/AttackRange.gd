extends Node2D

enum ShapeType { T_shape, X_shape,Y_shape }

@onready var i = TowerDataVault.get_selected_tower_data() as CustomData
@onready var temp = TowerDataVault.get_selected_tower_data() as CustomData
@onready var selected_shape = ShapeType[temp.attack_range]

#region shape data
var T_shape_positions: Array[Vector2] = [
	Vector2(0, -64), Vector2(0, 64), Vector2(64, -64), Vector2(-64, -64)
	]


var X_shape_positions: Array[Vector2] = [
	Vector2(-64, -64), Vector2(64, -64), Vector2(64, 64), Vector2(-64, 64)
	]


var Y_shape_positions : Array[Vector2] = [
	Vector2(-64, -64), Vector2(64, -64), Vector2(0, 64)
	]

#endregion

func _ready():
	var shape_positions = selected_shape_to_positions(selected_shape)
	set_shape_collection(shape_positions)

#returns an arrray of positions based on the enum selected in the editor
func selected_shape_to_positions(shape: ShapeType) :
	match shape:
		ShapeType.T_shape:
			return T_shape_positions
		ShapeType.X_shape:
			return X_shape_positions
		ShapeType.Y_shape:
			return Y_shape_positions

func set_shape_collection(shape_positions: Array[Vector2]) -> void:
	for child in get_children():
		child.queue_free()
	# i have no idea why but changhing the for variable form postion to something neutral doesnt work
	for pos in shape_positions:
		var new_shape = CollisionShape2D.new()
		new_shape.shape = RectangleShape2D.new()
		new_shape.shape.extents = Vector2(32, 32)
		new_shape.position = pos
		add_child(new_shape)
		new_shape.set_owner(self)
		var new_sprite = Sprite2D.new()
		new_sprite.texture = load("res://Assets/UI_assets/TowerRangeSprite.svg")
		new_sprite.position = pos
		add_child(new_sprite)
		new_sprite.set_owner(self)
