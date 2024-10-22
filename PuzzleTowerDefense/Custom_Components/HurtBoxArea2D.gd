# Represents a Hit dealt from the target perspective
extends Area2D
class_name HurtBoxArea2D
##this is the class recieves the raw damage,
## then calculates the final dmg and sends it to the health component

signal hit_landed(final_damage)

@export var armor := 0

func get_hurt(damage: int) -> void:
	print("i am about to take damage")
	var final_damage := damage - armor
	emit_signal("hit_landed", final_damage)
