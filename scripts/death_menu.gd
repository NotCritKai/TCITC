extends Control


#BUTTON CODES
func _on_return_button_pressed():
	get_tree().paused = false 
	queue_free()
	
func _on_quit_pressed():
	get_tree().quit()
#BUTTON CODES
