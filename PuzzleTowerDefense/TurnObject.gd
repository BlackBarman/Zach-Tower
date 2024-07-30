extends Node2D
signal ObjectInGame

@export var ObjectType: Enums.TurnObjects

#is the object actually in game and part of the turn structure?
var InTheField = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	get_tree().call_group("TurnManagerGroup", "_AddUnfieldedObject")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _ArriveOnTheField():
	InTheField = true


