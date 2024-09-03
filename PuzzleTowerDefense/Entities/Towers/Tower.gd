extends Node2D
class_name BaseTower

signal ActiveTooltip

var hovered :bool = false
var can_be_placed :bool = true
var placed : bool = true
enum State {
	Placed,
	Dragged,
}
@export var previewImage : Texture2D

@onready var tilemap : PlacementTilemap = get_parent()

@onready var RemoveButton = Popups.button


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
	AudioManager.BuildTower.play()


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
