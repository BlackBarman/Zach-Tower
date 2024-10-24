extends Node


func _change_level(new_level : PackedScene):
	get_tree().unload_current_scene()
	get_tree().change_scene_to_packed(new_level)
