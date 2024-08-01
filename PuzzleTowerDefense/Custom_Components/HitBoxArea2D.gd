class_name HitBoxArea2D
extends Area2D

# This is the class that sends damage to the hurtbox

@export var damage := 1
@export var can_hit_multiple := false

func apply_hit(hurt_box: HurtBoxArea2D) -> void:
	hurt_box.get_hurt(damage)
	set_deferred("monitoring", can_hit_multiple)

func _on_area_entered(area: Area2D) -> void:
	if area is HurtBoxArea2D:
		apply_hit(area)
