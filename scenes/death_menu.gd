extends Control


func _on_return_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Scene1GAME.tscn")
	
#Built in Godot Code that cancels a scene- 
#-when ESC is pressed and goes to whatever is told 
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/Scene1GAME.tscn")

	
	
	
