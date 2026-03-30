extends Control
@onready var audio_stream_player = $"../AudioStreamPlayer"
#allows the death sound/music to play 
@onready var f_to_attack = $"../../../f_to_attack"
#creates f to attack variable so it can be used for scene 1 

#-------------------------------------------------------------------------------
#Shop code
func _on_return_button_pressed():#when pressed it returns to the main scene 1  
	get_tree().paused = false #Unpauses everything
	queue_free()#Unpauses everything

func _on_quit_pressed():
	get_tree().quit()#When the player presses quit it closes the game completely
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
	var player = get_tree().root.get_node("Game/Player")#makes gm =GameManager 
	var gm = get_tree().current_scene.get_node("GameManager")#makes gm =GameManager 
	
	if gm.score >= 15: #If coins greater than or = 15 
		player.has_sword = true #player has the sword
		gm.subtract_point()#Subtracts 15 coins 
		get_tree().paused = false#paused in shop scene is false
		visible = false#Closes the shop scene
		queue_free()#Extra Close 
		$CSLABEL.visible = false#Makes all the labels invis
		$Instructions.visible = true #Makes the instructions visible in shop scene
		f_to_attack.visible = true#Makes the instructions visible in scene 1
		
	else:#if the player does not have 15 coins or more  
		player.has_sword = false#Player doesnt have sword
		print("Not enough coins!")#prints you do not have enough coins in the debugger
		
#-------------------------------------------------------------------------------

	

	
