extends Node2D

@export var BulletScene : PackedScene
@export var shooting_frame := 1
var current_frame = 0

var bullet #instance bullet
var Targets = []
var current_enemy = 0
var can_shoot = false
var debug_n_times_shot = 0

#TODO change weapon base on tower data

func _process(_delta):
	if Targets != [] :
		current_enemy = Targets[0]
		%AnimatedSprite2D.look_at(current_enemy.global_position)

func try_Shoot():
	if Targets != []:
		print("can shoot")
		bullet = BulletScene.instantiate()
		%AnimatedSprite2D.set_frame_and_progress(0, 0)
		%AnimatedSprite2D.play("ballista")
		EndLevelStats.shots_fired +=1
		print("Weapon: turno finito")
		await bullet.bulletDie


#shoots the actual bullet
func shoot():
	bullet.global_position = $Marker2D.position
	bullet.set_target(current_enemy)
	get_parent().add_child(bullet)
	AudioManager.ShootArrow.play()

	can_shoot = false # boolean is useless now that we use the turn manager

#fires the shoot function at the exact frame of the animation
#remeber to set the shooting_frame in the inspector
func _on_animated_sprite_2d_frame_changed():
	if current_frame == 6:
		current_frame = 0
	else:
		current_frame +=1
	if current_frame == shooting_frame:
		if Targets != []:
			shoot()
			print("shooted")
			debug_n_times_shot += 1
		else:
			bullet._die()
		#TODO See if debug_n_times_shot is used in other places as well,
		#after all we do want a variable that tracks
		#how many times the tower shot


func _on_attack_range_body_entered(body):
	if body.is_in_group("EnemyCollisionsGroup"):
		if body.get_parent().get_node("HealthComponent").Alive == true:
			Targets.append(body)

func _on_attack_range_body_exited(body):
	Remove_Target(body)

func Remove_Target(body):
	Targets.erase(body)
