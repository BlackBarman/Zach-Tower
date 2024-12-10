extends Label


func _ready():
	hide()

func _on_reload():
	show()
	$Timer.start()

func _on_timer_timeout():
	hide()
