extends Node

#Main variables
var score = 1#Score only increases by 1, at a time. 
@onready var control_menu = $"."

@onready var coin_label = $CanvasLayer2/CoinLabel
@onready var shop_menu = $"."
@onready var audio_stream_player = $"../AudioStreamPlayer"

#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
func _on_go_to_shop_button_pressed():
	var shop_scene = load("res://scenes/shop_menu.tscn")#loads thw shop  
	var shop = shop_scene.instantiate()#initiates shop OVERLAY
	get_tree().current_scene.get_node("GameManager/CanvasLayer2").add_child(shop)
	get_tree().paused = true #pauses
#shop button code
#-------------------------------------------------------------------------------
#pause menu button code 
func _on_pause_button_pressed():
	var pause_scene = load("res://scenes/pause_menu.tscn")#loads the menu  
	var pause = pause_scene.instantiate()#initiates menu 
	get_tree().current_scene.get_node("GameManager/CanvasLayer2/Pause_Button").add_child(pause)
	get_tree().paused = true #pauses
#-------------------------------------------------------------------------------
var playerWeaponEquip: bool
#-------------------------------------------------------------------------------
#secret win button 
func _on_win_button_pressed():#When the secret button is pressed it changes to the win scene 
	get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
#-------------------------------------------------------------------------------
	
func add_point():
	score += 1#adds a point to the score when the coin is collected
	coin_label.text = str(score) + " Coin(s)"#updates the label in scene 1 
	shop_menu.coin_label.text = str(score) + " Coin(s)"

func subtract_point():
	score -= 15#subtracts a point to the score when the coin is collected
	coin_label.text = str(score) + " Coin(s)"#updates the label in scene 1 
	shop_menu.coin_label.text = str(score) + " Coin(s)"#updates the label in scene 1 
#-------------------------------------------------------------------------------
