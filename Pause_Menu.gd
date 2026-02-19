extends Control



	
func _on_quit_button_pressed():
	get_tree().quit()

func _on_credits_button_pressed():
	var credits_scene = load("res://scenes/credits.tscn")#loads the menu  
	var credits = credits_scene.instantiate()#initiates scene 
	$Credits.visible = true
	

func _on_unpause_btn_pressed():
	get_tree().paused = false
	$Credits.visible = false
	queue_free()  

