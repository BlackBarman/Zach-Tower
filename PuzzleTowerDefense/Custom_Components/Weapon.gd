extends Node2D
class_name BaseWeapon

signal turn_done

@onready var data = TowerDataVault.get_selected_tower_data() as CustomData
@onready var anim_name : String = data.weapon_animation
@onready var BulletScene: PackedScene = data.bullet_scene
@onready var BulletDamage:int = data.Damage
@onready var Bullet_animation :String = data.bullet_animation
@onready var Bullet_impact : String   = data.bullet_impact_animation
@onready var reloading : int = data.fire_rate
@onready var kalans :Area2D = $"../AttackRange"

var bullet # a bullet instance

var Targets = []
var current_enemy = 0

var shooting_frame := 1
var current_frame = 0

var can_shoot = false
var active = false
var has_targets = false
var debug_n_times_shot := 0

func _ready():
	%AnimatedSprite2D.animation = anim_name


func _process(_delta):

	if Targets != [] :
		current_enemy = Targets[0]
		%AnimatedSprite2D.look_at(current_enemy.global_position)

# TODO use the method Area2d.get_overlapping_bodies() in
# addition to/instead of signals to populate the target array and
# find the right target, as signals sometimes break
func try_Shoot():
	print("tower has  " + str(Targets.size()) + "  enemies in range when we are trying to shoot")
	await get_tree().process_frame
	var _x = "ciao"
	if reloading >= data.fire_rate:
		reloading = 0
	elif reloading > 0:
		reloading += 1
		emit_signal("reloading, turn_done")
	elif reloading == 0 and (has_targets == false or Targets.size()==0) :
		emit_signal("turn_done")
		return

	if  not has_targets or Targets.is_empty():
		emit_signal("turn_done")
		return

	if not can_shoot and reloading == 0:
		#print("la torre sta per sparare")
		can_shoot = true
		current_enemy = Targets[0]
		%AnimatedSprite2D.set_frame_and_progress(0, 0)

		%AnimatedSprite2D.play(anim_name)
		print("animation was called") # this will call the shoot method at the specified frame

func end_the_turn():
	if %AnimatedSprite2D.is_playing():
		while %AnimatedSprite2D.is_playing():
			await get_tree().process_frame
	can_shoot = false
	emit_signal("turn_done")

#shoots the actual bullet
func shoot():
	print("shoot() was called")
	bullet = BulletScene.instantiate() as BaseBullet
	bullet.bullet_animation = Bullet_animation
	bullet.bullet_impact_animation = Bullet_impact
	bullet.bulletDie.connect(end_the_turn)
	bullet.damage = BulletDamage
	#bullet.position = $Marker2D.position
	bullet.set_target(current_enemy)
	get_parent().add_child(bullet)
	bullet.global_position = $AnimatedSprite2D/Marker2D.global_position
	AudioManager.ShootArrow.play()
	EndLevelStats.IncrementShootFired()
	EndLevelStats.AddDamageTowers(bullet.Get_Damage())
	if !active:
		active = true


#fires the shoot function at the exact frame of the animation
func _on_animated_sprite_2d_frame_changed():
	current_frame += 1
	if current_frame == shooting_frame and can_shoot == true:
		print("tower should shoot")
		if Targets != []:
			shoot()
			can_shoot = false
			debug_n_times_shot += 1


func _on_animated_sprite_2d_animation_finished():
	current_frame = 0


#region add and remove target to target array
func _on_attack_range_body_entered(body):
	if body.is_in_group("EnemyCollisionsGroup"):
		Targets.append(body)
		has_targets = true

func _on_attack_range_body_exited(body):
	if body.is_in_group("EnemyCollisionsGroup"):
		Targets.erase(body)
	if Targets != []:
		current_enemy = Targets[0]
	elif Targets == null:
		has_targets = false

#endregion



