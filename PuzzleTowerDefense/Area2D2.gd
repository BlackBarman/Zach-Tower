extends Area2D

var original_modulate

# Called when the node enters the scene tree for the first time.
func _ready():
	original_modulate = $"../Tower01".modulate
	$"../Tower01".modulate = Color("green")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	$"../Tower01".modulate = Color("red")
	pass # Replace with function body.


func _on_body_exited(body):
	$"../Tower01".modulate = original_modulate
	pass # Replace with function body.
