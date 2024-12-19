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
@onready var dmg_type : String = data.Damage_type

var bullet # a bullet instance

var Targets :Array[BaseEnemy] = [] #all base enemies in tower range
var enemies_to_dmg:Array[BaseEnemy] = [] # enemies to deal dmg to 
var current_enemy : BaseEnemy  # enemy to look at when shooting, the enemy at wich we are shooting to 

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
	# do the dmg here
	find_enemies_to_dmg() 
	assign_dmg() 
	#TODO also make a match to determine what ar the actual enemies to assign dmg to
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

#sort enemies based on how far they are in the path
func sort_enemies(a,b):
	if a.progress < b.progress: 
		return true
	else :
		return false

#HACK using magic valus here, too tired to do otherwise,
# also i am not rewarded by beautiful code
# change if i have time and energy, for now copy values from 
# TowerData.gd
func find_enemies_to_dmg():
	match data.Damage_type:
		"PIERCING":
			Targets.sort_custom(sort_enemies)
			enemies_to_dmg = Targets.slice(0,3)
			print("this is a PIERCING weapon")
		"NORMAL":
			print("this is a NORMAL weapon")
			pass
		"AOE":
			print("this is a AOE weapon")
			pass
		"KILL":
			print("this is a KILL weapon")
			pass
	pass

func assign_dmg():
	for i in enemies_to_dmg:
		i.health_component._Damage(BulletDamage)
	pass

#called by proj on death
func on_proj_death():
	#waits for the animation to finish before calling the end of turn signal 
	if %AnimatedSprite2D.is_playing():
		while %AnimatedSprite2D.is_playing():
			await get_tree().process_frame 
	
	shoot_anim_playing = false
	
	#TODO we need to differentatiate between Targets in range and targets we hit
	for i in Targets :
		i.health_component._CheckDeath()
	
	emit_signal("turn_done")
	

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
#TODO append the full scene not just the body
func _on_attack_range_body_entered(body):
	if body.is_in_group("EnemyCollisionsGroup") and body.is_class("CharacterBody2D"):
		Targets.append(body.get_parent())
		has_targets = true

func _on_attack_range_body_exited(body):
	if body.is_in_group("EnemyCollisionsGroup") and body.is_class("CharacterBody2D"):
		Targets.erase(body.get_parent())
	if Targets != []:
		current_enemy = Targets[0]
	elif Targets == null:
		has_targets = false

#endregion



