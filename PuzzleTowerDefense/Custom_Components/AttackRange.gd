extends Node2D

enum ShapeType { T_shape, X_shape,X_shape_2, X_shape_3, Y_shape, DOWN_3, UP_3, LEFT_3, RIGHT_3, PLUS_1, PLUS_2, AROUND_1, AROUND_2x2_1}


@onready var temp = TowerDataVault.get_selected_tower_data() as CustomData
@onready var selected_shape = ShapeType[temp.attack_range]

#region shape data
#shapes
var T_shape_positions: Array[Vector2] = [Vector2(0, -64), Vector2(0, 64), Vector2(64, -64), Vector2(-64, -64)]
var X_shape_positions: Array[Vector2] = [Vector2(-64, -64), Vector2(64, -64), Vector2(64, 64), Vector2(-64, 64)]
var X_shape_positions_2 : Array[Vector2] =[Vector2(64, -64), Vector2(128, -128), Vector2(-128, -128), Vector2(-64, -64), Vector2(-64, 64), Vector2(-128, 128), Vector2(64, 64), Vector2(128, 128)]
var X_shape_positions_3 : Array[Vector2] =[Vector2(64, -64), Vector2(128, -128), Vector2(-128, -128), Vector2(-192, -192), Vector2(192, -192), Vector2(192, 192), Vector2(-192, 192), Vector2(-64, -64), Vector2(-64, 64), Vector2(-128, 128), Vector2(64, 64), Vector2(128, 128)]
var Y_shape_positions : Array[Vector2] = [Vector2(-64, -64), Vector2(64, -64), Vector2(0, 64)]


# PLUS signs
var PLUS_sign_1 : Array[Vector2] = [Vector2(0, -64), Vector2(-64, 0), Vector2(0, 64), Vector2(64, 0)]
var PLUS_sign_2 : Array[Vector2] = [Vector2(0, -64), Vector2(0, -128), Vector2(-128, 0), Vector2(-64, 0), Vector2(0, 64), Vector2(0, 128), Vector2(64, 0), Vector2(128, 0)]

# directions
var DOWN_3_square : Array[Vector2] = [Vector2(0, 64), Vector2(0, 192), Vector2(0, 128)]
var UP_3_square   : Array[Vector2] = [Vector2(0, -192), Vector2(0, -64), Vector2(0, -128)]
var LEFT_3_square : Array[Vector2] = [Vector2(-64, 0), Vector2(-128, 0), Vector2(-192, 0)]
var RIGHT_3_square: Array[Vector2] = [Vector2(64, 0), Vector2(128, 0), Vector2(192, 0)]

#perimeters
var AROUND_1      : Array[Vector2] = [Vector2(64, 0), Vector2(0, -64), Vector2(-64, 64), Vector2(-64, -64), Vector2(-64, 0), Vector2(0, 64), Vector2(64, 64), Vector2(64, -64)]
var AROUND_2x2_1  : Array[Vector2] = [Vector2(-64, 0), Vector2(0, -64), Vector2(64, -64), Vector2(-64, 64), Vector2(128, 0), Vector2(0, 128), Vector2(128, 64), Vector2(64, 128)]
#endregion

func _ready():
	var shape_positions = selected_shape_to_positions(selected_shape)
	set_shape_collection(shape_positions)

#returns an arrray of positions based on the enum selected in the editor
func selected_shape_to_positions(shape: ShapeType):
	match shape :
		ShapeType.T_shape:
			return T_shape_positions
		ShapeType.X_shape:
			return X_shape_positions
		ShapeType.X_shape_2:
			return X_shape_positions_2
		ShapeType.X_shape_3:
			return X_shape_positions_3
		ShapeType.Y_shape:
			return Y_shape_positions
		ShapeType.DOWN_3:
			return DOWN_3_square
		ShapeType.UP_3:
			return UP_3_square
		ShapeType.LEFT_3:
			return LEFT_3_square
		ShapeType.RIGHT_3:
			return RIGHT_3_square
		ShapeType.PLUS_1:
			return PLUS_sign_1
		ShapeType.PLUS_2:
			return PLUS_sign_2
		ShapeType.AROUND_1:
			return AROUND_1
		ShapeType.AROUND_2x2_1:
			return AROUND_2x2_1

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
