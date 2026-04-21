extends Control

#-------------------------------------------------------------------------------
func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Scene1GAME.tscn")
	#when the player presses the character button it switches to the main scene
#-------------------------------------------------------------------------------


func _on_button_2_pressed():
	Gamemanager.skin = true 
	get_tree().change_scene_to_file("res://scenes/Scene1GAME.tscn")
#when the player presses it says that the girl character is true and switches to the main scene
