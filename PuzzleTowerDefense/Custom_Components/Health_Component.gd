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


# Called every frame. 'delta' is the elapsed time since the previous frame.

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
		#kill the parent entity
		print("Enemy killed")
		get_parent().queue_free()


#func _on_hurt_box_area_2d_hit_landed(final_damage):
	#print("un milione e mezzo di botte ho preso")
	#_Damage(final_damage)

