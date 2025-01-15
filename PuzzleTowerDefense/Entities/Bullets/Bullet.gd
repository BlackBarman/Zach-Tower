extends Node2D
class_name BaseBullet

signal bulletDie


var move = Vector2.ZERO
var target  # an enemy class
var target_pos : Vector2
var current_animation : String = ""
var bullet_animation : String
var bullet_impact_animation : String
## leeway for errors now that we rely on position and not physics
var allowed_range = 10 
##pixels per seconds
@export var projectile_speed = 100
var damage : int # real value passed by the weapon


func _ready():
	if target != null :
		look_at(target.global_position)
		$AnimatedSprite2D.play(bullet_animation)


func _process(delta):
	if current_animation == bullet_impact_animation:
		return
	if global_position.distance_to(target.global_position) <= allowed_range:  
		play_impact_animation(bullet_impact_animation)
	# if we have no target we look at where it was and we go straight 
	# until we exit the screen, at that point a signal
	# will kill us
	if target == null:
		look_at(target_pos) #we spawened therefore we had a target at some point but it might be dead already
		var x = global_position.move_toward(target_pos * 9999999, projectile_speed * delta  )
		global_position = x
	else:
		look_at(target_pos)
		var ciao = global_position.move_toward(target_pos, projectile_speed * delta)
		global_position = ciao
	


func set_target(enemy):
	target = enemy 
	target_pos = target.global_position


# TODO : when i reach enemy position switch to impact anim and then die
# TODO : change the sprite node to an animation player 
func play_impact_animation(impact_animation: String):
	current_animation = impact_animation
	if $AnimatedSprite2D.animation != impact_animation:
		$AnimatedSprite2D.play(impact_animation)
	else :
		assert(false , "ERROR! : bullt not calling impact animation")

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

