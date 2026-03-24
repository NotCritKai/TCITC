extends Control

#-------------------------------------------------------------------------------
#when the game starts it starts the functions
func _ready():
	pass #Replace with function body
#-------------------------------------------------------------------------------
#When the game starts it makes all of the pixels work 
func _process(_delta):
	pass
#-------------------------------------------------------------------------------
#When the player presses start it changes to the character selection scene
func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/Character_Selction.tscn")
#-------------------------------------------------------------------------------
#if the player presses quit it exits the game completely 
func _on_quit_pressed():
	get_tree().quit()
#-------------------------------------------------------------------------------
