extends Node
class_name HealthComponent

@export var CurrentHealth = 0
@export var MaxHealth = 0


signal Death()
signal HealthChangePositive
signal HealthChangeNegative


func _ready():
	CurrentHealth = MaxHealth


func _Heal(life):
	CurrentHealth += life
	HealthChangePositive.emit()


func _Damage(x):
	CurrentHealth -= x
	HealthChangeNegative.emit()
	print(str(self)+ "ha preso "+ str(x) + " danni")
	#_CheckDeath()

#we check death at the end of each towers phase
func _CheckDeath():
	if(CurrentHealth <= 0):
		Death.emit()
		get_parent().queue_free()


