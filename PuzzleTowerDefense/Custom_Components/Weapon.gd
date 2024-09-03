extends Node2D

@export var Bullet : PackedScene
@export var shooting_frame := 1
var current_frame = 0

var Targets = []
var current_enemy = 0
var can_shoot = false
var debug_n_times_shot = 0



signal end_Turn

#TODO change weapon base on tower data

func _process(_delta):
	#print(str(is_playing())
	if Targets != [] :
		current_enemy = Targets[0]
		%AnimatedSprite2D.look_at(current_enemy.global_position)

func try_Shoot():
	if Targets != []:
		print("can shoot")
		%AnimatedSprite2D.set_frame_and_progress(0, 0)
		%AnimatedSprite2D.play("ballista")
		EndLevelStats.shots_fired +=1
		await end_Turn

#shoots the actual bullet
func shoot():
	var b= Bullet.instantiate()

	b.global_position = $Marker2D.position
	b.set_target(current_enemy)
	get_parent().add_child(b)
	AudioManager.ShootArrow.play()

	can_shoot = false # boolean is useless now that we use the turn manager
	await b.bulletDie
	emit_signal("end_Turn")

#fires the shoot function at the exact frame of the animation
#remeber to set the shooting_frame in the inspector
func _on_animated_sprite_2d_frame_changed():
	if current_frame == 6:
		current_frame = 0
	else:
		current_frame +=1
	if current_frame == shooting_frame:
		shoot()
		debug_n_times_shot += 1
		#TODO See if debug_n_times_shot is used in other places as well,
		#after all we do want a variable that tracks
		#how many times the tower shot


func _on_attack_range_body_entered(body):
	if body.is_in_group("EnemyCollisionsGroup"):
		Targets.append(body)

func _on_attack_range_body_exited(body):
	Targets.erase(body)


func _on_timer_timeout():
	var b= Bullet.instantiate()
	b.bulletDie
	emit_signal("end_Turn")
	pass # Replace with function body.
