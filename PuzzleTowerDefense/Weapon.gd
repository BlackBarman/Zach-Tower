extends AnimatedSprite2D

@export var Bullet : PackedScene
@export var shooting_frame := 1
var current_frame = 0

var Targets = []
var current_enemy = 0
var can_shoot = false

signal end_Turn


func _process(_delta):
	if Targets != []:
		current_enemy = Targets[0]
		$"..".look_at(current_enemy.global_position)
	
	#print("targetable enemies: ", Targets.size() )

#populate taget array
func _on_area_2d_body_entered(body):
	if body.is_in_group("EnemyGroup"):
		Targets.append(body)

#depopulate target array
func _on_area_2d_body_exited(body):
	Targets.erase(body)

#THIS WILL NEED TO BE REFACTORED ONCE WE START TO USE A TURN STRUCTURE 
# for now it plays the animation once every wait time seconds id we have targets
#func _on_fire_rate_timeout():
	#if Targets != []:
		#play("shoot")
		
func try_Shoot():
	if Targets != []:
		play("shoot")
		
		
		

#calls the shoot function on the right frame
func _on_frame_changed():
	if current_frame == 6:
		current_frame = 0
	else:
		current_frame +=1
	if current_frame == shooting_frame:
		shoot()

#shoots the actual bullet
func shoot():
	var b= Bullet.instantiate()
	b.global_position = $"../Marker2D".position
	b.set_target(current_enemy)
	get_parent().add_child(b)
	can_shoot = false
	$"../../FireRate".start()

