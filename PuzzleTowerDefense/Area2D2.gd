extends Area2D


func _on_body_entered(body):
	$"../Tower01".modulate = Color("red")
	pass # Replace with function body.


func _on_body_exited(body):
	$"../Tower01".modulate = Color("green")
	pass # Replace with function body.
