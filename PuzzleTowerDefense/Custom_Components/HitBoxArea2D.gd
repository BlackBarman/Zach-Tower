class_name HitBoxArea2D
extends Area2D

# This is the class that sends damage to the hurtbox

var damage #passed on ready by the bullet
@export var can_hit_multiple := false

func apply_hit(hurt_box: HurtBoxArea2D) -> void:
	hurt_box.get_hurt(damage)

#if hitbox touches hurbox, hitbox tells hurtbox how much damage to deal to itself
# veeeery convoluted 
func _on_area_entered(area: Area2D) -> void:
	if area is HurtBoxArea2D:
		apply_hit(area)


