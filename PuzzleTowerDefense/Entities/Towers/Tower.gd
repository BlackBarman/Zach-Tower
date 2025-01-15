extends Node2D
class_name BaseTower

signal ActiveTooltip
signal TowerTurnDone

var can_be_placed :bool = true
var placed : bool = false
var space_occupied = 1
var data
enum State {
	Placed,
	Dragged,
}


@onready var tilemap : PlacementTilemap = get_parent()

@onready var RemoveButton = Popups.button


func _ready():
	tilemap.tower_placed.connect(tower_was_placed)
	RemoveButton.pressed.connect(_remove_tower)
	data = TowerDataVault.get_selected_tower_data() as CustomData
	%Tooltip.data = data # passes tower data file to popup
	%TowerSprite.texture = data.tower_sprite

func _on_color_switcher_body_entered(_body):
	can_be_placed = false

func _on_color_switcher_body_exited(_body):
	can_be_placed = true

func tower_was_placed():
	%AttackRange.hide()
	emit_signal("ActiveTooltip")
	AudioManager.BuildTower.play()
	placed = true

#called by turn manager
func _execute_Turn():
	await get_tree().process_frame
	$Weapon.try_Shoot()
	await  $Weapon.turn_done
	emit_signal("TowerTurnDone")

func _remove_tower():
	if Popups.TooltipTower == $".":
		EndLevelStats.RemoveSpaceUsed(space_occupied)
		EndLevelStats.RemoveTowersPlaced()
		EndLevelStats.RemoveMoneySpent(data.cost)
		queue_free()

func rotate_attack_range():
	%AttackRange.rotate(PI/2)


