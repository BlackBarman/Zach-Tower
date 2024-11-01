extends BaseBullet

@export var aoe_radius = 150  # Radius of the explosion
@export var aoe_damage = 2   # Damage for enemies within the AoE
var hit_enemy: HurtBoxArea2D = null  # Keep track of the enemy directly hit



# When the projectile hits something
func _on_hit_box_area_2d_area_entered(area):
	if area is HurtBoxArea2D:
		hit_enemy = area  # Store the enemy that was hit
		play_impact_animation(bullet_impact_animation)
		_apply_aoe_damage()

# Applies AoE damage to all enemies except the one directly hit
func _apply_aoe_damage():
	# Get all enemies in the "enemies" group
	var enemies = get_tree().get_nodes_in_group("EnemyGroup")

	# Loop through each enemy to check if they are within the AoE radius
	for enemy in enemies:
		if enemy != hit_enemy:
			var distance = global_position.distance_to(enemy.global_position)

			# If the enemy is within the AoE radius, apply damage
			if distance <= aoe_radius:
				hitbox.damage = damage
				 # Assuming the projectile has a hitbox component
				hitbox.apply_hit(enemy.find_child("HurtBoxArea2D"))  # Apply damage through the hitbox

	# Destroy the projectile after applying AoE damage
	_die()
