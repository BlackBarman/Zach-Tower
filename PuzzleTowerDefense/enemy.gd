extends PathFollow2D

@export var speed = 30

func initialize(position):
	var ition = position

func _process(delta):
	progress += delta * speed
