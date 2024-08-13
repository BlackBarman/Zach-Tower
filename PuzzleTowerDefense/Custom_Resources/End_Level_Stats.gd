extends Node
class_name LevelStats

 
var shots_fired = 0
var space_used = 0
var money_spent = 0
var overkill = 0
var avg_tower_damage = 0 #TODO: implement set get function, i waan the ui to pull data dynamically
var towers_placed = 0
var inactive_towers = 0 


func reset_data():
	shots_fired = 0
	space_used = 0
	money_spent = 0
	overkill = 0
	avg_tower_damage = 0 #TODO: implement set get function, i waan the ui to pull data dynamically
	towers_placed = 0
	inactive_towers = 0 
