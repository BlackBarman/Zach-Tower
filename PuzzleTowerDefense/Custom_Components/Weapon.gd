extends AnimatedSprite2D

@export var Bullet : PackedScene
@export var shooting_frame := 1
var current_frame = 0

var Targets = []
var current_enemy = 0
var can_shoot = false
var debug_n_times_shot = 0

signal end_Turn


func _process(_delta):
	#print(str(is_playing())
	if Targets != [] :
		current_enemy = Targets[0]
		$"..".look_at(current_enemy.global_position)
	#elif Targets[0]== null:
		#for i in Targets:
			#if i != null:
				#current_enemy = i
				#break

	#print("targetable enemies: ", Targets.size() )


#THIS WILL NEED TO BE REFACTORED ONCE WE START TO USE A TURN STRUCTURE 
# for now it plays the animation once every wait time seconds id we have targets
func try_Shoot():
	if Targets != []:
		print("can shoot")
		set_frame_and_progress(0, 0)
		play("shoot")
		EndLevelStats.shots_fired +=1
		await end_Turn

#calls the shoot function on the right frame
func _on_frame_changed():
	if current_frame == 6:
		current_frame = 0
	else:
		current_frame +=1
	if current_frame == shooting_frame:
		shoot()
		debug_n_times_shot += 1
		#print("ho sparato questo numero di volte: ", debug_n_times_shot)





#shoots the actual bullet
func shoot():
	var b= Bullet.instantiate()
	b.global_position = $"../Marker2D".position
	#array_is_all_okay()
	b.set_target(current_enemy)
	get_parent().add_child(b)
	
	can_shoot = false # boolean is useless
	await b.bulletDie
	emit_signal("end_Turn")

func _on_area_2d_body_entered(body):
	if body.is_in_group("EnemyCollisionsGroup"):
		Targets.append(body)


func _on_area_2d_body_exited(body):
	Targets.erase(body)


#func array_is_all_okay():
	#for i in Targets:
		#if i == null:
			#Targets.erase(i)
	#current_enemy = Targets[0]
