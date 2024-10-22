extends VBoxContainer


func _ready():
	EndLevelStats.moneyChanged.connect(_updateMoney)
	
func _updateMoney():
	$Label.text = "Money Spent: " + str(EndLevelStats.money_spent)
