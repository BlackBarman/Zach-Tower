extends Node
class_name HealthComponent

@export var CurrentHealth = 0
@export var MaxHealth = 0
@export var cara : HurtBoxArea2D


signal Death()
signal HealthChangePositive
signal HealthChangeNegative


func _ready():
	cara.hit_landed.connect(_Damage)
	CurrentHealth = MaxHealth


func _Heal(life):
	CurrentHealth += life
	HealthChangePositive.emit()


func _Damage(x):
	CurrentHealth -= x
	HealthChangeNegative.emit()
	_CheckDeath()


func _CheckDeath():
	if(CurrentHealth <= 0):
		Death.emit()
		get_parent().queue_free()


