extends Node2D
class_name BaseWeapon

signal turn_done

@onready var data = TowerDataVault.get_selected_tower_data() as CustomData
@onready var anim_name : String = data.weapon_animation
@onready var BulletScene: PackedScene = data.bullet_scene
@onready var BulletDamage:int = data.Damage
@onready var Bullet_animation :String = data.bullet_animation
@onready var Bullet_impact : String   = data.bullet_impact_animation
var bullet # a bullet instance

var Targets = []
var current_enemy = 0

var shooting_frame := 1
var current_frame = 0

var can_shoot = false
var active = false
var has_targets = false
var debug_n_times_shot := 0
@onready var kalans :Area2D = $"../AttackRange"

func _ready():
	%AnimatedSprite2D.animation = anim_name


func _process(_delta):
	if Targets != [] :
		current_enemy = Targets[0]
		%AnimatedSprite2D.look_at(current_enemy.global_position)

func try_Shoot():
	#var _y = kalans.get_overlapping_bodies() #TODO use this method in addition to signals to populate the target array and find the right target, as signals somethimes break
	#for i in _y :
		#print("la Torre ha un nemico in range" + str(i))
	await get_tree().process_frame
	if has_targets== false:
		turn_done.emit()
		return
	if Targets.size() == 0 or Targets == null :
		turn_done.emit()
		return

	if Targets.size() != 0 and not can_shoot:
		can_shoot = true
		current_enemy = Targets[0]
		%AnimatedSprite2D.set_frame_and_progress(0, 0)
		%AnimatedSprite2D.play(anim_name) # this will call the shoot method at the specified frame

func end_the_turn():
	print("the bullet is dying!")
	can_shoot = false
	turn_done.emit()

#shoots the actual bullet
func shoot():
	bullet = BulletScene.instantiate() as BaseBullet
	bullet.bullet_animation = Bullet_animation
	bullet.bullet_impact_animation = Bullet_impact
	bullet.bulletDie.connect(end_the_turn)
	bullet.damage = BulletDamage
	bullet.global_position = $Marker2D.position
	bullet.set_target(current_enemy)
	get_parent().add_child(bullet)
	AudioManager.ShootArrow.play()
	EndLevelStats.IncrementShootFired()
	EndLevelStats.AddDamageTowers(bullet.Get_Damage())
	if !active:
		active = true


#fires the shoot function at the exact frame of the animation
func _on_animated_sprite_2d_frame_changed():
	if current_frame == 6:
		current_frame = 0
	else:
		current_frame +=1
	if current_frame == shooting_frame and can_shoot == true:
		if Targets != []:
			shoot()
			can_shoot = false
			debug_n_times_shot += 1


#region add and remove target to target array
func _on_attack_range_body_entered(body):
	if body.is_in_group("EnemyCollisionsGroup"):
		Targets.append(body)
		has_targets = true
		#print("Enemy entered range. Total targets: ", Targets.size())

func _on_attack_range_body_exited(body):
	if body.is_in_group("EnemyCollisionsGroup"):
		Targets.erase(body)
	if Targets != []:
		current_enemy = Targets[0]
	elif Targets == null:
		has_targets = false
		print("tower has no valid targets")
	#print("Enemy exited range. Total targets: ", Targets.size())

#endregion
