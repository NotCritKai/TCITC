extends Control

func _ready():
	$CanvasLayer.visible = false

#BUTTON CODES
func _on_return_button_pressed():
	get_tree().paused = false and get_tree().change_scene_to_file("res://scenes/Scene1GAME.tscn")
	
#Built in Godot Code that cancels a scene- 
#-when ESC is pressed and goes to whatever is told 
#BUTTON CODES
