extends Resource
class_name CustomData



@export_category("tower stats")
@export var Damage : int
@export var Damage_type : String
@export_range(0,5) var fire_rate : int  ## numero di turni tra spari: 0 spara ogni turno, 1 spara un turno si e uno no, e così via
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


