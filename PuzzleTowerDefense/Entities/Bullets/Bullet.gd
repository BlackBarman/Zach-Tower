extends Node2D
class_name BaseBullet

signal bulletDie

var speed = 100
var move = Vector2.ZERO
var look_vector = Vector2.ZERO
var target
var current_animation : String = ""
var bullet_animation : String
var bullet_impact_animation : String
@export var projectile_speed = 25
@export var hitbox : HitBoxArea2D
var damage :int #real value passed by the weapon



# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox.damage = damage
	if target != null :
		look_at(target.global_position)
		look_vector= target.global_position - global_position
		$AnimatedSprite2D.play(bullet_animation)


func set_target(enemy):
	target = enemy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_animation == bullet_impact_animation:
		return
	move = move.move_toward(look_vector, delta )
	move = move.normalized()
	global_position += (move * projectile_speed/100)


func _on_visible_on_screen_notifier_2d_screen_exited():
	_die()

#dmg will be applied automatically by the hitbox to the
#hurtbox and  from the hurtbox to the health component
func _on_hit_box_area_2d_area_entered(area):
	if area is HurtBoxArea2D:
		play_impact_animation(bullet_impact_animation)



func play_impact_animation(animation_name: String):
	current_animation = animation_name
	$AnimatedSprite2D.play(animation_name)


func _die():
	emit_signal("bulletDie")
	queue_free()


func _on_animated_sprite_2d_animation_finished():
	# Only call _die if the impact animation has finished
	if current_animation == bullet_impact_animation:
		_die()


func Get_Damage() -> int:
	return damage
