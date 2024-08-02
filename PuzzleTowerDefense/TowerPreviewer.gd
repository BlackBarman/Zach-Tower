extends Area2D

var original_modulate

# Called when the node enters the scene tree for the first time.
func _ready():
	original_modulate = $"../Tower01".modulate


func _on_body_entered(body):
	$"../Tower01".modulate = Color("red")



func _on_body_exited(body):
	$"../Tower01".modulate = original_modulate

