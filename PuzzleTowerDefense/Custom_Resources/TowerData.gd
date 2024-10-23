extends Resource
class_name CustomData



@export_category("tower stats")
@export var Damage : int
@export var Damage_type : String
@export_enum("FAST:1", "SLOW:2","VERY SLOW:60") var fire_rate : int
@export var preview_image : Texture
@export_enum("T_shape","Y_shape","X_shape") var attack_range : String
@export var tower_sprite : Texture
@export var bullet_scene : PackedScene
@export var cost : int
@export_enum("ballista","cannon","catapult",
			"electriccrystal","goldenballista",
			"magicmirror","magicrod","sling") var weapon_animation : String
@export_enum("arrow","cannonball","catapultstone",
			"goldenarrow","slingstone",
			"spark","magicrod",) var bullet_animation : String
@export_enum("arrow_impact","cannonball_impact","catapultstone_impact",
			"goldenarrow_impact","slingstone_impact",
			"spark_impact",) var bullet_impact_animation : String


