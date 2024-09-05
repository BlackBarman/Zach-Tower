extends Resource
class_name CustomData

# to improve :
#Export an int or String property as an enumerated list of options. If the property is an int, then the index of the value is stored, in the same order the values are provided. You can add explicit values using a colon. If the property is a String, then the value is stored.
#
#
#@export_enum("Warrior", "Magician", "Thief") var character_class: int
#@export_enum("Slow:30", "Average:60", "Very Fast:200") var character_speed: int
#@export_enum("Rebecca", "Mary", "Leah") var character_name: String
#
#
# or just make a bunch of enums and export them,
# might be better if same enum is used by other stuff:
#enum CharacterName {REBECCA, MARY, LEAH}
#@export var character_name: CharacterNam
#


@export_category("tower stats")

@export var Damage : int
@export var Damage_type : String
@export_enum("FAST:1", "SLOW:2","VERY SLOW:60") var fire_rate : int
@export var preview_image : Texture
#this way if this specific tres needs to be used by a scene different
# than the base tower we can pass that packed scene to the tilemap
@export var Tower_Scene :PackedScene



