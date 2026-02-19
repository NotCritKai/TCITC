extends Control


#BUTTON CODES
func _on_return_button_pressed():
	get_tree().paused = false 
	queue_free()
	
#BUTTON CODES

func _on_try_again_pressed():
		get_tree().change_scene_to_file("res://scenes/Scene1GAME.tscn")


func _on_quit_pressed():
	get_tree().quit()
