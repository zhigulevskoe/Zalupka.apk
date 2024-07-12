extends Control

@onready var main = $"../.."
	
	
func _on_continue_pressed():
	main.pauseMenu()

func _on_escape_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
