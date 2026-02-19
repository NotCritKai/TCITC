extends Control


func _on_exit_pressed():
	var pause_scene = load("res://scenes/pause_menu.tscn")#loads the menu  
	var pause = pause_scene.instantiate()#initiates menu 
	get_tree().current_scene.get_node("GameManager/CanvasLayer2/Pause Button").add_child(pause)
	get_tree().paused = true #pauses

#FIX HERE
