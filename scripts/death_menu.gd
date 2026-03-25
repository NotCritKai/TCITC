extends Control

@onready var f_to_attack = $"../../../f_to_attack"

#-------------------------------------------------------------------------------
#Shop code
func _on_return_button_pressed():#when pressed it returns to the main scene 1  
	get_tree().paused = false 
	queue_free()#Unpauses everything

func _on_quit_pressed():
	get_tree().quit()
#Shop code
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#Death menu code is here for some reason....
func _on_try_again_pressed():#restarts main scene 1 
	get_tree().change_scene_to_file("res://scenes/Scene1GAME.tscn")
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#when the button is pressed in the shop 
#it enables the player and the sword and the button dissapears
func _on_corruption_sword_pressed():
	var player = get_tree().root.get_node("Game/Player")
	var gm = get_tree().current_scene.get_node("GameManager")
	
	if gm.score >= 15:
		player.has_sword = true 
		gm.subtract_point()
		get_tree().paused = false
		visible = false
		queue_free()
		$CSLABEL.visible = false
		$Instructions.visible = true 
		f_to_attack.visible = true
		
	else:
		player.has_sword = false
		print("Not enough coins!")
		print("Not enough coins")

#-------------------------------------------------------------------------------

	

	
