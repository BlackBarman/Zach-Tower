extends Node2D
var speed = 100
var move = Vector2.ZERO
var look_vector = Vector2.ZERO
var target 

signal bulletDie

# Called when the node enters the scene tree for the first time.
func _ready():
	if target != null :
		look_at(target.global_position)
		look_vector= target.global_position - global_position
		$AnimatedSprite2D.play("default")
func set_target(enemy):
	target = enemy
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move = move.move_toward(look_vector, delta)
	move = move.normalized()
	global_position += move

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("this bullet exited the screen so it's going to die")
	_die()

 

func _on_hit_box_area_2d_area_entered(area):
	if area is HurtBoxArea2D:
		#print("this bullet is dying")
		_die()

func _die():
	emit_signal("bulletDie")
	queue_free()
