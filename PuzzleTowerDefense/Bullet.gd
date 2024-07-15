extends Node2D

var speed = 100
var move = Vector2.ZERO
var look_vector = Vector2.ZERO
var target 
# Called when the node enters the scene tree for the first time.
func _ready():
	if target != null :
		look_at(target.global_position)
		look_vector= target.global_position - global_position
		$AnimatedSprite2D.play("default")
	pass # Replace with function body.

func set_target(enemy):
	target = enemy

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move = move.move_toward(look_vector, delta)
	move = move.normalized()
	global_position += move
	
	pass
