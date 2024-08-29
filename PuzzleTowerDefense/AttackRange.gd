extends Node2D

# Define the available shapes using an enum
enum ShapeType { T_shape, X_shape,Y_shape }

@export var selected_shape: ShapeType = ShapeType.T_shape

var T_shape_positions: Array[Vector2] = [
	Vector2(0, -64), Vector2(0, 64), Vector2(64, -64), Vector2(-64, -64)
	]


var X_shape_positions: Array[Vector2] = [
	Vector2(-64, -64), Vector2(64, -64), Vector2(64, 64), Vector2(-64, 64)
	]
	

var Y_shape_positions : Array[Vector2] = [
	Vector2(-64, -64), Vector2(64, -64), Vector2(0, 64)
	]

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

	for position in shape_positions:
		var new_shape = CollisionShape2D.new()
		new_shape.shape = RectangleShape2D.new()
		new_shape.shape.extents = Vector2(32, 32)
		new_shape.position = position
		add_child(new_shape)
		new_shape.set_owner(self)

		var new_sprite = Sprite2D.new()
		new_sprite.texture = load("res://Assets/UI_assets/TowerRangeSprite.svg")
		new_sprite.position = position
		add_child(new_sprite)
		new_sprite.set_owner(self)