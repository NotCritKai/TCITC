extends Control



	
func _on_quit_button_pressed():
	get_tree().quit()

func _on_credits_button_pressed():
	$Credits.visible = true
	

func _on_unpause_btn_pressed():
	$Credits.visible = false
	get_tree().paused = false
	queue_free()


