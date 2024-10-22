extends Node2D
class_name BaseWeapon

signal shot_fired
signal turn_done

@onready var data = TowerDataVault.get_selected_tower_data() as CustomData
@onready var anim_name : String = data.weapon_animation
@onready var BulletScene: PackedScene = data.bullet_scene
@onready var BulletDamage:int = data.Damage
var bullet #instance bullet

var Targets = []
var current_enemy = 0

var shooting_frame := 1
var current_frame = 0

var can_shoot = false
var active = false
var has_targets = false
var debug_n_times_shot := 0
var sonostatachiamataxvolte := 0
@onready var kalans :Area2D = $"../AttackRange"

func _ready():
	%AnimatedSprite2D.animation = anim_name


func _process(_delta):
	if Targets != [] :
		current_enemy = Targets[0]
		%AnimatedSprite2D.look_at(current_enemy.global_position)

func try_Shoot():
	var _y = kalans.get_overlapping_bodies()
	for i in _y :
		print("la Torre ha un nemico in range" + str(i))
	await get_tree().process_frame
	if has_targets== false:
		return
	sonostatachiamataxvolte +=1
	if Targets == null:
		return

	print("try_shoot() chiamata "+str(sonostatachiamataxvolte)+" volte")
	if Targets.size() != 0:
		var _x = Targets.size()
		current_enemy = Targets[0]
		bullet = BulletScene.instantiate()
		bullet.damage = BulletDamage
		%AnimatedSprite2D.set_frame_and_progress(0, 0)
		%AnimatedSprite2D.play(anim_name)
		#waits for the bullet to send the dead signal
		#before retrying to shoot
		await shot_fired
		await bullet.bulletDie


#shoots the actual bullet
func shoot():
	if bullet == null: #and current_enemy != null:
		bullet = BulletScene.instantiate()
	bullet.damage = BulletDamage
	bullet.global_position = $Marker2D.position
	bullet.set_target(current_enemy)
	get_parent().add_child(bullet)
	AudioManager.ShootArrow.play()
	EndLevelStats.IncrementShootFired()
	EndLevelStats.AddDamageTowers(bullet.Get_Damage())
	can_shoot = false # boolean is useless now that we use the turn manager
	if !active:
		active = true

#fires the shoot function at the exact frame of the animation
func _on_animated_sprite_2d_frame_changed():
	if current_frame == 6:
		current_frame = 0
	else:
		current_frame +=1
	if current_frame == shooting_frame:
		if Targets != []:
			shot_fired.emit()
			await get_tree().process_frame
			shoot()
			debug_n_times_shot += 1


#region add and remove target to target array
func _on_attack_range_body_entered(body):
	if body.is_in_group("EnemyCollisionsGroup"):
		Targets.append(body)
		has_targets = true
		print("Enemy entered range. Total targets: ", Targets.size())

func _on_attack_range_body_exited(body):
	if body.is_in_group("EnemyCollisionsGroup"):
		Targets.erase(body)
	if Targets != []:
		current_enemy = Targets[0]
	elif Targets == null:
		has_targets = false
		print("tower has no valid targets")
	print("Enemy exited range. Total targets: ", Targets.size())

#endregion
