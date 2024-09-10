extends Node2D
var speed = 100
var move = Vector2.ZERO
var look_vector = Vector2.ZERO
var target
var current_animation = ""
@export var projectile_speed = 25
signal bulletDie

#TODO change bullet animation based on the weapon, using a dictionary
#TODO play impact animation upon impact, then kill the projectile


# Called when the node enters the scene tree for the first time.
func _ready():
	if target != null :
		look_at(target.global_position)
		look_vector= target.global_position - global_position
		$AnimatedSprite2D.play("arrow")
		var timer = get_tree().create_timer(0.5).timeout

func set_target(enemy):
	target = enemy

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_animation == "arrow_impact":
		return
	move = move.move_toward(look_vector, delta * projectile_speed)
	move = move.normalized()
	global_position += move

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("this bullet exited the screen so it's going to die")
	_die()

func _on_hit_box_area_2d_area_entered(area):
	if area is HurtBoxArea2D:
		play_animation("arrow_impact")
		#$AnimatedSprite2D.play("arrow_impact")
		#print("this bullet is dying")

func play_animation(animation_name: String):
	current_animation = animation_name
	$AnimatedSprite2D.play(animation_name)


func _die():
	emit_signal("bulletDie")
	queue_free()

func _on_animated_sprite_2d_animation_finished():
	print("Bullet finished the animation")
	# Only call _die if the impact animation has finished
	if current_animation == "arrow_impact":
		_die()

