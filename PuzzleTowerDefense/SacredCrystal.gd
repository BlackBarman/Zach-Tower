extends Node2D
class_name SacredCrystal

@export var lose_screen : PackedScene

func _on_area_2d_body_entered(body):
	if body.is_in_group("EnemyGroup"):
		var x = lose_screen.instantiate()
		get_tree().root.add_child(x)

