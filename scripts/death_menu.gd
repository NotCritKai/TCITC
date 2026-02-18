extends Control

@onready var corruption_sword_button = $"Corruption Sword Button"
@onready var corruption_sword_text = $"Corruption Sword Text"

#BUTTON CODES
func _on_return_button_pressed():
	get_tree().paused = false 
	queue_free()
	
#BUTTON CODES

func _on_try_again_pressed():
		get_tree().change_scene_to_file("res://scenes/Scene1GAME.tscn")


func _on_quit_pressed():
	get_tree().quit()



func _on_corruption_sword_button_pressed():
	#Format for removing items from shop temporarily

	remove_child(corruption_sword_button)
	remove_child(corruption_sword_text)
