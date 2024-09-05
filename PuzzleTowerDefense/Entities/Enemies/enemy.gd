extends PathFollow2D
#how many tiles it moves in a single turn
@export var speed = 1
const tileSize = 64
var canMoveForward = false
var targetProgress = 0
var animationSpeed = 120 #how quickly it moves forward. doesn't influence gameplay


signal end_Turn
signal enemy_died

func _process(delta):

	if (canMoveForward):
		_move_Forward(delta)
	#print("totalProgress ",targetProgress)
	#print("progress ", progress)
	#pass
	#progress += delta * speed
func _execute_Turn():
	targetProgress = progress + (tileSize * speed)
	print("targetProgress changed: ", targetProgress)
	canMoveForward = true
	await end_Turn

func _move_Forward(delta):
	if (progress < targetProgress):
		progress += delta * animationSpeed
		$CharacterBody2D/AnimatedSprite2D.play("Move")
	elif (progress >= targetProgress):
		print("progress reached")
		#AudioManager.EnemyMove.play()
		progress = targetProgress
		canMoveForward = false
		$CharacterBody2D/AnimatedSprite2D.play("Idle")
		emit_signal("end_Turn")


func _on_health_component_death():
	AudioManager.EnemyDeath.play()
	emit_signal("enemy_died")
	$CharacterBody2D/AnimatedSprite2D.play("Death")
	pass # Replace with function body.
