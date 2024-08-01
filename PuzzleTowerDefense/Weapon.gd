extends AnimatedSprite2D

@export var Bullet : PackedScene

var Targets = []
var current_enemy = 0
var can_shoot = true
var Tile_length = 64
var highlighted_tiles: Dictionary = {}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Targets != []:
		current_enemy = Targets[0]
		$"..".look_at(current_enemy.global_position)
		shoot()


func shoot():
	if can_shoot:
		$".".play("shoot")
		var b= Bullet.instantiate()
		b.global_position = $Marker2D.position
		b.set_target(current_enemy)
		get_parent().add_child(b)
		can_shoot = false
		$"../../FireRate".start()


func _on_area_2d_body_entered(body):
	Targets.append(body)

func _on_area_2d_body_exited(body):
	Targets.erase(body)

func _on_fire_rate_timeout():
	can_shoot = true


func _check_enemy_in_range():
	for target in Targets:
		for tile in highlighted_tiles:
			var x = 0
