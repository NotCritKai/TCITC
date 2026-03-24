extends Control
#-------------------------------------------------------------------------------	
func _on_quit_button_pressed():
	get_tree().quit()
	#if the player presses quit on the menu it exits the game fully
#-------------------------------------------------------------------------------
func _on_credits_button_pressed():
	$Credits.visible = true
	#when credits button is pressed it overlays the menu 
#-------------------------------------------------------------------------------
#when unpause is pressed it says all variables are not visible and queues free 
func _on_unpause_btn_pressed():
	$Credits.visible = false
	get_tree().paused = false
	queue_free()
#-------------------------------------------------------------------------------
#initiates and overlays the control menu 
func _on_controls_button_pressed():
	$ControlMenu.visible = true
#-------------------------------------------------------------------------------
