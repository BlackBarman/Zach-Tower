extends Node
class_name LevelStats

signal moneyChanged
signal enemyKilled

var shots_fired = 0
var space_used = 0       
var money_spent = 0
var overkill = 0         
var avg_tower_damage = 0 
var towers_placed = 0    
var inactive_towers = 0  
var tot_towers_damage = 0
var enemies_killed = 0

func reset_data():
	shots_fired = 0
	space_used = 0
	money_spent = 0
	overkill = 0
	tot_towers_damage = 0
	avg_tower_damage = 0 
	towers_placed = 0
	inactive_towers = 0
	enemies_killed = 0

func retrieve_avg_towers_damage(n_towers) -> float:
	avg_tower_damage = float(tot_towers_damage) / float(n_towers)
	return avg_tower_damage

func retrieve_inactive_towers():
	for tower in get_tree().get_nodes_in_group("TowerGroup"):
		if tower.get_node("Weapon").active == false:
			IncrementInactiveTowers()


func GetShootFired() -> int:
	return shots_fired

func IncrementShootFired():
	shots_fired += 1

func AddSpaceUsed(number):
	space_used += number

func RemoveSpaceUsed(number):
	space_used -= number

func IncrementTowersPlaced():
	towers_placed += 1

func RemoveTowersPlaced():
	towers_placed -= 1

func IncrementInactiveTowers():
	inactive_towers += 1

func AddDamageTowers(number):
	tot_towers_damage += number

func AddMoneySpent(number):
	money_spent += number
	emit_signal("moneyChanged")

func RemoveMoneySpent(number):
	money_spent -= number
	emit_signal("moneyChanged")

func EnemyKilled():
	enemies_killed += 1
	emit_signal("enemyKilled")
