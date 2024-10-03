extends Node
class_name LevelStats


var shots_fired = 0      #
var space_used = 0       # TODO space used = number of towers placed (for now)
var money_spent = 0      # TODO implement money variable in towers and update this variable each time a ower is placed
var overkill = 0         # Nico TODO Implement a way to know how much damage is wasted when a given bullet hits a given enemy, then update this variable (in this script) accordingly
var avg_tower_damage = 0 # Nico TODO: implement set get function, i want the ui to pull data dynamically
var towers_placed = 0    # TODO: space used = number of towers placed (for now)
var inactive_towers = 0  # Nico TODO: A way to know the towers that didn't get used
var tot_towers_damage = 0

func reset_data():
	shots_fired = 0
	space_used = 0
	money_spent = 0
	overkill = 0
	tot_towers_damage = 0
	avg_tower_damage = 0 #TODO: implement set get function, i waan the ui to pull data dynamically
	towers_placed = 0
	inactive_towers = 0

func GetShootFired() -> int:
	return shots_fired

func IncrementShootFired():
	shots_fired += 1

func AddSpaceUsed(number):
	space_used += number

func IncrementTowersPlaced():
	towers_placed += 1

func IncrementInactiveTowers():
	inactive_towers += 1

func AddDamageTowers(number):
	tot_towers_damage += number

func AddMoneySpent(number):
	money_spent += number
