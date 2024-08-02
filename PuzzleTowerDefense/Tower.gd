extends Node2D
class_name BaseTower

var can_be_placed :bool = false



func _on_color_switcher_body_entered(body):
	can_be_placed = false


func _on_color_switcher_body_exited(body):
	can_be_placed = true



