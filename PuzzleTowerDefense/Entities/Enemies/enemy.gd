extends PathFollow2D
class_name BaseEnemy
#how many tiles it moves in a single turn
@export var speed = 1
@export var enemyName = "Blue Slime"
const tileSize = 64
var canMoveForward = false
var targetProgress = 0
var animationSpeed = 120 #how quickly it moves forward. doesn't influence gameplay


 #HACK for some reasons unknown to man making the $CharacterBody2D/CollisionShape2D2
# smaller and to the front of the enemy solves many of the issue we are currently facing
# with targets detection, however this is not optimal
signal end_Turn

func _process(delta):
	if (canMoveForward):
		_move_Forward(delta)


func _execute_Turn():
	targetProgress = progress + (tileSize * speed)
	canMoveForward = true
	await end_Turn



func _move_Forward(delta):
	if (progress < targetProgress):
		progress += delta * animationSpeed
		$CharacterBody2D/AnimatedSprite2D.play("Walk right")
	elif (progress >= targetProgress):
		#AudioManager.EnemyMove.play()
		progress = targetProgress
		canMoveForward = false
		$CharacterBody2D/AnimatedSprite2D.play("Idle right")
		emit_signal("end_Turn")


func _on_health_component_death():
	AudioManager.EnemyDeath.play()


func _on_health_component_health_change_negative():
	if self != null and $AnimationPlayer != null: #bleah
		$AnimationPlayer.play("hitted")
	$CharacterBody2D/AnimatedSprite2D.play("Hurt")
