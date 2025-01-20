extends Node2D
class_name BaseWeapon

signal turn_done

@onready var data = TowerDataVault.get_selected_tower_data() as CustomData
@onready var anim_name: String = data.weapon_animation
@onready var BulletScene: PackedScene = data.bullet_scene
@onready var BulletDamage: int = data.Damage
@onready var Bullet_animation: String = data.bullet_animation
@onready var Bullet_impact: String = data.bullet_impact_animation
@onready var reloading: int = data.fire_rate
@onready var dmg_type: String = data.Damage_type
@onready var tower_position 

var bullet # A bullet instance
var Targets: Array[BaseEnemy] = []   # All base enemies in tower range
var enemies_to_dmg: Array[BaseEnemy] = []  # Enemies to deal damage to
var current_enemy: BaseEnemy         # Enemy to look at when shooting

var shooting_frame := 1
var current_frame = 0

var shoot_anim_playing = false
var active = false
var has_targets = false
var debug_n_times_shot := 0

func _ready():
	%AnimatedSprite2D.animation = anim_name
	tower_position = get_parent().global_position

func _process(_delta):
	if Targets != []:
		current_enemy = Targets[0]
		%AnimatedSprite2D.look_at(current_enemy.global_position)


# Attempt to shoot if the tower is ready
func try_Shoot():
	await get_tree().process_frame
	# Reload logic
	if reloading == data.fire_rate and not Targets.is_empty():
		reloading = 0 
	elif reloading != data.fire_rate:
		reloading = min(reloading + 1, data.fire_rate) # Increment reloading
		$ReloadLabel._on_reload()
		emit_signal("turn_done")
		return

	if not has_targets or Targets.is_empty():
		emit_signal("turn_done")
		return
		
	# Fire when ready
	if not shoot_anim_playing and reloading == 0 and has_targets:
		current_enemy = Targets[0]
		shoot_anim_playing = true
		%AnimatedSprite2D.set_frame_and_progress(0, 0)
		%AnimatedSprite2D.play(anim_name) # Calls the shoot method at the specified frame

# Perform the actual shooting logic
func shoot():
	bullet = BulletScene.instantiate() as BaseBullet
	
	if dmg_type == "PIERCING" :
		bullet.is_piercing = true
	
	bullet.set_target(current_enemy)
	bullet.bullet_animation = Bullet_animation
	bullet.bullet_impact_animation = Bullet_impact
	bullet.bulletDie.connect(on_proj_death)
	
	get_parent().add_child(bullet)
	bullet.global_position = $AnimatedSprite2D/Marker2D.global_position
	AudioManager.ShootArrow.play()
	EndLevelStats.IncrementShootFired()
	EndLevelStats.AddDamageTowers(bullet.Get_Damage())
	if not active:
		active = true

# Sort enemies based on their progress along the path
func sort_enemies(a, b):
	if a.progress < b.progress: 
		return true
	else:
		return false

# Determine the enemies to damage
func find_enemies_to_dmg():
	match data.Damage_type:
		"PIERCING":
			var target = Targets[0]
		
			var target_to_tower: Vector2= (target.position - tower_position).normalized()
			target_to_tower.normalized()
			var all_live_enemies = get_tree().get_nodes_in_group("EnemyGroup")
			enemies_to_dmg = get_enemies_to_pierce(all_live_enemies, target_to_tower)
		
		"NORMAL":
			enemies_to_dmg = Targets.slice(0)
			
		"AOE":
			var all_live_enemies = get_tree().get_nodes_in_group("EnemyGroup")
			Targets.sort_custom(sort_enemies)
			all_live_enemies.sort_custom(sort_enemies)
			var target_index = all_live_enemies.find(Targets.front())
			enemies_to_dmg = get_neighbors(all_live_enemies, target_index)
			
		"KILL":
			enemies_to_dmg = Targets.slice(0)
			pass


func get_enemies_to_pierce(all_enemies, enemy_tower_vector):
	var similar_enemies : Array[BaseEnemy] = []
	var target = Targets[0]
	var debug_dot = []
	for i in all_enemies :
		enemy_tower_vector.normalized()
		var i_to_tower : Vector2 = (i.global_position - tower_position).normalized()
		i_to_tower.normalized()
		var dot = clamp(enemy_tower_vector.dot(i_to_tower),-1.0, 1.0)
		
		debug_dot.append(dot)
		if dot > 0.95  :
			similar_enemies.append(i)
	
	similar_enemies.append(target)
	print(str(similar_enemies))
	print(str(debug_dot))
	return similar_enemies 

# Helper function to get neighboring enemies
func get_neighbors(array: Array, value: int):
	var index = value
	
	if value == -1:
		return []
	
	var neighbors := []
	
	if index > 0:
		neighbors.append(array[index - 1])
	
	neighbors.append(array[index])
	
	if index < array.size() - 1:
		neighbors.append(array[index + 1])
	
	return neighbors

# Assign damage to selected enemies
func assign_dmg():
	for enemy in enemies_to_dmg:
		enemy.health_component._Damage(BulletDamage)

# Handle projectile death
func on_proj_death():
	if %AnimatedSprite2D.is_playing():
		while %AnimatedSprite2D.is_playing():
			await get_tree().process_frame 
	
	shoot_anim_playing = false
	emit_signal("turn_done")

# Fire the shoot function when shooting frame is reached
func _on_animated_sprite_2d_frame_changed():
	current_frame += 1
	if current_frame == shooting_frame:
		find_enemies_to_dmg()
		assign_dmg()
		shoot()
		debug_n_times_shot += 1

func _on_animated_sprite_2d_animation_finished():
	current_frame = 0
	shoot_anim_playing = false

#region Add and remove targets to target array
func _on_attack_range_body_entered(body):
	if body.is_in_group("EnemyCollisionsGroup") and body.is_class("CharacterBody2D"):
		Targets.append(body.get_parent())
		has_targets = true

func _on_attack_range_body_exited(body):
	if body.is_in_group("EnemyCollisionsGroup") and body.is_class("CharacterBody2D"):
		Targets.erase(body.get_parent())
	if Targets != []:
		current_enemy = Targets[0]
	elif Targets == null:
		has_targets = false
#endregion

