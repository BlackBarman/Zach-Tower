extends BaseBullet

@export var max_hits = 9999  ## change this number if needed from weapon
var hit_count = 0


func _process(delta):
	if target == null:
		look_at(target_pos) #we spawened therefore we had a target at some point but it might be dead already
		var x = global_position.move_toward(target_pos * 9999999, projectile_speed * delta  )
		global_position = x
	else:
		look_at(target_pos)
		var ciao = global_position.move_toward(target_pos, projectile_speed * delta  )
		global_position = ciao

