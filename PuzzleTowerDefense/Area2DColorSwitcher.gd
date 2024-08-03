extends Area2D
class_name ColorSwitcher

@export var object_to_modulate : Node2D
@export var good_color : Color
@export var bad_color : Color



func _on_body_entered(_body):
	object_to_modulate.modulate = Color(bad_color)


func _on_body_exited(_body):
	object_to_modulate.modulate = Color(good_color)

