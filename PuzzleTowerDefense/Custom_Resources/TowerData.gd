extends Resource
class_name CustomData

# ////////////////////////////////////////
#        Tower base
# ////////////////////////////////////////

@export_category("tower base")
## the base that will be placed on the ground, not necessarly base tower
@export var tower_scene  : PackedScene
## the image that the UI elemets will use to display a thumbnail of this tower
@export var preview_image : Texture
## sprite the tower base will use to render itself
@export var tower_sprite : Texture
## shape of the attack range, not every range is compatible with every tower base
@export_enum("T_shape", "X_shape","X_shape_2", "X_shape_3",
"Y_shape", "DOWN_3", "UP_3","LEFT_3", "RIGHT_3","PLUS_1", "PLUS_2","AROUND_1","AROUND_2x2_1") var attack_range : String
## cost of the tower, DUH
@export var cost : int

# ////////////////////////////////////////
#            Weapons and bullet
# ////////////////////////////////////////

@export_category("weapon and bullet")
## scene the weapon component will shoot
@export var bullet_scene : PackedScene
## value the weapon component will give to the bullet
@export var Damage : int
@export var Damage_type : String
## numero di turni tra spari: 0 spara ogni turno, 1 spara un turno si e uno no, e così via
@export_range(0,10) var fire_rate : int  

# ////////////////////////////////////////
#             Animations
# ////////////////////////////////////////

@export_category("Animations")
@export_enum("ballista","cannon","catapult",
			"electriccrystal","goldenballista",
			"magicmirror","magicrod","sling") var weapon_animation : String
@export_enum("arrow","cannonball","catapultstone",
			"goldenarrow","slingstone",
			"spark","magicrod",) var bullet_animation : String
@export_enum("arrow_impact","cannonball_impact","catapultstone_impact",
			"goldenarrow_impact","slingstone_impact",
			"spark_impact",) var bullet_impact_animation : String
