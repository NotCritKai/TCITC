extends Control


#--------SHOP
func _on_return_button_pressed():
	get_tree().paused = false 
	queue_free()
	
func _on_quit_pressed():
	get_tree().quit()
#--------SHOP



#--------------------------------DEATH MENU??
func _on_try_again_pressed():
	get_tree().change_scene_to_file("res://scenes/Scene1GAME.tscn")
#--------------------------------DEATH MENU??











func _on_corruption_sword_pressed():
	pass # Replace with function body.
