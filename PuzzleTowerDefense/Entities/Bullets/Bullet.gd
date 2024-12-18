extends Node2D
class_name BaseBullet

signal bulletDie



var move = Vector2.ZERO
var target 
var current_animation : String = ""
var bullet_animation : String
var bullet_impact_animation : String
##pixels per seconds
@export var projectile_speed = 10
var damage : int # real value passed by the weapon


# Called when the node enters the scene tree for the first time.
func _ready():
	print("projectile speed is " + str(projectile_speed))
	if target != null :
		look_at(target.global_position)
		print("target is at position " + str(target.global_position))
		$AnimatedSprite2D.play(bullet_animation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_animation == bullet_impact_animation:
		return
	if global_position == target.global_position :
		print("ímpact animation called")
		play_impact_animation(bullet_impact_animation)
		#move = move.move_toward(target.global_position, delta)
		#move = move.normalized()
		#global_position += (move * projectile_speed)
		#global_position += global_position.move_toward(target.global_position, delta).normalized() *  projectile_speed
		
	else:
		look_at(target.global_position)
		var ciao = global_position.move_toward(target.global_position, projectile_speed * delta  )
		global_position = ciao


func set_target(enemy):
	target = enemy 
	target = target 


# TODO : when i reach enemy position switch to impact anim and then die
# TODO : change the sprite node to an animation player 
func play_impact_animation(impact_animation: String):
	current_animation = impact_animation
	if $AnimatedSprite2D.animation != impact_animation:
		$AnimatedSprite2D.play(impact_animation)
	else :
		print("i am not calling impact animation")

func _on_visible_on_screen_notifier_2d_screen_exited():
	_die()

func _on_animated_sprite_2d_animation_finished():
	# Only call _die if the impact animation has finished
	if current_animation == bullet_impact_animation:
		_die()

func _die():
	emit_signal("bulletDie")
	queue_free()

#getter function for end level stats
func Get_Damage() -> int:
	return damage

##############################################################
##dmg will be applied automatically by the hitbox to the
##hurtbox and  from the hurtbox to the health component
#func _on_hit_box_area_2d_area_entered(area):
	#if area is HurtBoxArea2D:
		#play_impact_animation(bullet_impact_animation)
