extends Area2D
class_name ColorSwitcher

@export var object_to_modulate : Node2D
@export var good_color : Color
@export var bad_color : Color
#color different than the original, but we can still place
@export var use_good_color: bool  = false   #

@onready var original_color = object_to_modulate.modulate
@onready var tower = $".."

#HACK we are not checking what kind of bodies we are touching,
#there might be shanangans of an enemy toching a tower making
#the tower red
func _on_body_entered(_body):
	negative_color()

func _on_body_exited(_body):
	positive_color()

# make so that we can't place a towe on top of another tower
func _on_area_entered(area):
	if area.is_in_group("TowerArea2D") and not tower.placed:
		tower.can_be_placed = false
		negative_color()

func _on_area_exited(area):
	if area.is_in_group("TowerArea2D") and not tower.placed:
		tower.can_be_placed = true
		positive_color()


func positive_color():
	if use_good_color :
		object_to_modulate.modulate = Color(good_color)
	else:
		object_to_modulate.modulate = Color(original_color)


func negative_color():
	object_to_modulate.modulate = Color(bad_color)

