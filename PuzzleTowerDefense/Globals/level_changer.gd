extends Node

func _change_level(new_level : String):
	#get_tree().unload_current_scene()
	get_tree().change_scene_to_file(new_level)

