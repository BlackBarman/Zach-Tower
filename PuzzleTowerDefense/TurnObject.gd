extends Node2D


@export var ObjectType: Enums.TurnObjects

#is the object actually in game and part of the turn structure?
var InTheField = false
var parent = get_parent()

	
func _executeTurn():
	parent._startTurn()
