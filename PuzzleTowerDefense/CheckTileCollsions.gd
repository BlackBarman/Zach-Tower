extends Area2D

var numero := 0
@export var me :Sprite2D

func _process(delta):
	global_position = get_viewport().get_mouse_position()

func change_color(x):
	if x == 1 :
		me.modulate = Color("red")
	else :
		me.modulate = Color("green")
	pass


func _on_body_entered(body):
	print("i am colliding")
	numero +=1
	print("ho colpito"+str(numero)+"volte")
	change_color(1)
	pass # Replace with function body.


func _on_body_exited(body):
	change_color(0)
	pass # Replace with function body.
