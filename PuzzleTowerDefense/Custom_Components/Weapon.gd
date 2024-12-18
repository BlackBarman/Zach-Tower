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

var shoot_anim_playing = false
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
	
	await get_tree().process_frame
	#reload logic
	if reloading == data.fire_rate and not Targets.is_empty(): 	 #colpo in canna non iniziare a ricaricare se hai il colpo in canna ma no nemici in vista
		reloading = 0 
	elif reloading != data.fire_rate: #colpo non in canna
		reloading = min(reloading + 1, data.fire_rate) #99% same as reloading++
		#print_rich("[color=red] RELOADING!! [/color]")
		$ReloadLabel._on_reload()
		emit_signal("turn_done")
		return

	if not has_targets or Targets.is_empty():
		emit_signal("turn_done")
		return
		
#colpo é in canna e nemici sono in vista 
	if not shoot_anim_playing and reloading == 0 and has_targets: 
		current_enemy = Targets[0]
		shoot_anim_playing = true
		%AnimatedSprite2D.set_frame_and_progress(0, 0)
		%AnimatedSprite2D.play(anim_name)# this will call the shoot method at the specified frame


#shoots the actual bullet
func shoot():
	bullet = BulletScene.instantiate() as BaseBullet
	bullet.set_target(current_enemy)
	bullet.bullet_animation = Bullet_animation
	bullet.bullet_impact_animation = Bullet_impact
	bullet.bulletDie.connect(on_proj_death)
	
	#TODO remove this and assign dmg to target manually, at the end of bullet animation
	bullet.damage = BulletDamage
	
	
	#bullet.position = $Marker2D.position
	get_parent().add_child(bullet)
	bullet.global_position = $AnimatedSprite2D/Marker2D.global_position
	AudioManager.ShootArrow.play()
	EndLevelStats.IncrementShootFired()
	EndLevelStats.AddDamageTowers(bullet.Get_Damage())
	if !active:
		active = true

#called by proj on death
func on_proj_death():
	#waits for the animation to finish before calling the end of turn signal 
	if %AnimatedSprite2D.is_playing():
		while %AnimatedSprite2D.is_playing():
			await get_tree().process_frame 
	shoot_anim_playing = false
	emit_signal("turn_done")
	
	#TODO assign dmg to enemy manually here, 

#fires the shoot function when shooting frame is reached
func _on_animated_sprite_2d_frame_changed():
	current_frame += 1
	if current_frame == shooting_frame:
		shoot()
		debug_n_times_shot += 1


func _on_animated_sprite_2d_animation_finished():
	current_frame = 0
	shoot_anim_playing = false


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



