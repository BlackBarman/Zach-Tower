extends Node

@export var CurrentHealth = 0
@export var MaxHealth = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	CurrentHealth = MaxHealth
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _Heal(life):
	CurrentHealth += life
	HealthChangePositive.emit()
	
func _Damage(Damage):
	CurrentHealth -= Damage
	HealthChangeNegative.emit()
	_CheckDeath()


func _CheckDeath():
	if(CurrentHealth <= 0):
		Death.emit()


signal Death()

signal HealthChangePositive

signal HealthChangeNegative
