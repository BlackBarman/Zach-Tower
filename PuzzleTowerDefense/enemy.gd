extends PathFollow2D

@export var speed = 1

const tileSize = 64

var canMoveForward = false
var targetProgress = 0
var animationSpeed = 30

signal end_Turn

func _process(delta):
	
	if (canMoveForward):
		_move_Forward(delta)
	#print("totalProgress ",targetProgress)
	#print("progress ", progress)
	#pass
	#progress += delta * speed

func _execute_Turn():
	targetProgress = progress + (tileSize * speed)
	print("targetProgress changed")
	canMoveForward = true
	await end_Turn
	

func _move_Forward(delta):
	if (progress < targetProgress):
		progress += delta * animationSpeed
	elif (progress >= targetProgress):
		progress = targetProgress
		canMoveForward = false
		emit_signal("end_Turn")
		
