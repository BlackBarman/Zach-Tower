extends AnimatedSprite2D

@export var Bullet = preload("res://bullet_2.tscn")

var Targets = []
var current_enemy = 0
var can_shoot = true


func _ready():
	print("ciao")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Targets != []:
		current_enemy = Targets[0]
		$"..".look_at(current_enemy.global_position)
		shoot()
	pass

func shoot():
	if can_shoot:
		$".".play("shoot")
		#print("pew pew pew")
		var b= Bullet.instantiate()
		b.global_position = $Marker2D.position
		b.set_target(current_enemy)
		get_parent().add_child(b)
		can_shoot = false
		$"../../FireRate".start()
	else :
		print("reloading...")




func _on_area_2d_body_entered(body):
	Targets.append(body)
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	Targets.erase(body)
	pass # Replace with function body.


func _on_fire_rate_timeout():
	can_shoot = true
	pass # Replace with function body.
