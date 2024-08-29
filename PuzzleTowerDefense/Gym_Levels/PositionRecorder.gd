@tool
extends Node2D

# Array to store the positions
@export var positions: Vector2  
var nodes_to_track : Array
@export var array_to_populate : Array

func _ready():
	if Engine.is_editor_hint():
		array_to_populate.clear()
		print("ho iniziallizato puoi andare")
		

func _process(_delta):
	if Engine.is_editor_hint() and Input.is_action_just_pressed("ui_down"):
		nodes_to_track = get_children()
		for i in nodes_to_track:
			record_position_function(i)
		print_array_as_string(array_to_populate)


func record_position_function(i) -> void:
	var pos = i.position
	array_to_populate.append(pos)
	print("Position recorded: ", pos)


func print_array_as_string(array: Array) -> void:
	var output = "["
	for i in range(array.size()):
		var pos = array[i]
		output += "Vector2(" + str(pos.x) + ", " + str(pos.y) + ")"
		if i < array.size() - 1:
			output += ", "
	output += "]"
	print(output)
