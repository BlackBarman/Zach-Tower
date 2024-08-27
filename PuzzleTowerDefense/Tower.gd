extends Node2D
class_name BaseTower

var hovered :bool = false
var can_be_placed :bool = false
var placed : bool = true
enum State {
	Placed, 
	Dragged,
}

@onready var tilemap : PlacementTilemap = get_parent()


func _ready():
	tilemap.tower_placed.connect(tower_was_placed)

func _on_color_switcher_body_entered(_body):
	can_be_placed = false

func _on_color_switcher_body_exited(_body):
	can_be_placed = true

func tower_was_placed():
	$Node2D2.hide()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT and hovered:
		queue_free()


func _on_remove_area_mouse_entered():
	hovered = true


func _on_remove_area_mouse_exited():
	hovered = false

func _execute_Turn():
	await %AnimatedSprite2D.try_Shoot()
