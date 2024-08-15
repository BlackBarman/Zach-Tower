extends Node2D
class_name BaseTower

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

func _execute_Turn():
	await %AnimatedSprite2D.try_Shoot()

