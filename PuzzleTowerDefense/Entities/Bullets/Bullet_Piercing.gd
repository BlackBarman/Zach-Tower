extends BaseBullet

@export var max_hits = 9999  #TODO: change this number if needed from weapon
var hit_count = 0

func _on_hit_box_area_2d_area_entered(area):
	if area is HurtBoxArea2D:
		hit_count += 1
		if hit_count >= max_hits:
			play_impact_animation(bullet_impact_animation)
			_die()
