extends PanelContainer
class_name Tooltip

signal buttonsSignal
#TODO make so that this doesn't hold the TowerData itself as
# later in the project the base tower will have it as well and we don't want to
# have duplicate data

var data : CustomData # value passed by base tower
var popup
var DisplayPopup = false
var hovered :bool = false


func _on_mouse_entered():
	hovered = true
	%AttackRange.show()

func _on_mouse_exited():
	hovered = false
	%AttackRange.hide()

func _input(event):
	if hovered and DisplayPopup and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and data != null and not GlobalState.is_level_playing :
		if Popups.Get_ItemPopup().visible == false:
			AudioManager.SelectTower.play()
		Popups.open_popup(Rect2i(Vector2i(global_position),Vector2i(size)),data, get_parent() as BaseTower)

#starts a timer so we don't display the tooltip immediatly
func _on_base_tower_active_tooltip():
	await get_tree().create_timer(0.5).timeout
	DisplayPopup = true

