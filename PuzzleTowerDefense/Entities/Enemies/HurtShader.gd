extends AnimationPlayer


@onready var hurtbox = $"../CharacterBody2D/HurtBoxArea2D"


func _ready():
	hurtbox.hit_landed.connect(something_hit_me)

# plays the hurt animation when we recieve a signal from the hurtbox
# amount of dm5g is currently useless but is a value that we get from the signal, so godot expects a matching signature
func something_hit_me(_amount_of_dmg):
	self.play("hitted")
