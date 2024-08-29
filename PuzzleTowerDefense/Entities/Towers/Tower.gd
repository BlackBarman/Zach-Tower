extends Node2D
class_name BaseTower

signal ActiveTooltip

var hovered :bool = false
var can_be_placed :bool = false
var placed : bool = true
enum State {
	Placed, 
	Dragged,
}

@onready var tilemap : PlacementTilemap = get_parent()

@onready var RemoveButton = Popups.button

@onready var BuildTower = $BuildTower

func _ready():
	tilemap.tower_placed.connect(tower_was_placed)
	RemoveButton.pressed.connect(_remove_tower)
	
func _on_color_switcher_body_entered(_body):
	can_be_placed = false

func _on_color_switcher_body_exited(_body):
	can_be_placed = true

func tower_was_placed():
	%AttackRange.hide()
	emit_signal("ActiveTooltip")
	BuildTower.play()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT and hovered:
		queue_free()


func _on_remove_area_mouse_entered():
	hovered = true


func _on_remove_area_mouse_exited():
	hovered = false

func _execute_Turn():
	await $Weapon.try_Shoot()


func _remove_tower():
	if Popups.TooltipTower == $".":
		queue_free()

func _on_tooltip_buttons_signal():
	pass # Replace with function body.
