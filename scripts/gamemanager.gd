extends Node

var score = 1

@onready var coin_label = $CanvasLayer2/CoinLabel
@onready var coins_l = $Coins_L
@onready var shop_menu = $"."
#main variables
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
func add_point():	
	score += 1#Adds coins to the counter when  they are collected 
	coin_label.text =str(score) + " Coins"
	shop_menu.coin_label.text =str(score) + " Coins"
#-------------------------------------------------------------------------------
func _on_go_to_shop_button_pressed():
	var shop_scene = load("res://scenes/shop_menu.tscn")#loads thw shop  
	var shop = shop_scene.instantiate()#initiates shop OVERLAY
	get_tree().current_scene.get_node("GameManager/CanvasLayer2").add_child(shop)
	get_tree().paused = true #pauses
#shop button code
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
#pause menu button code 
func _on_pause_button_pressed():
	var pause_scene = load("res://scenes/pause_menu.tscn")#loads the menu  
	var pause = pause_scene.instantiate()#initiates menu 
	get_tree().current_scene.get_node("GameManager/CanvasLayer2/Pause_Button").add_child(pause)
	get_tree().paused = true #pauses
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
var playerWeaponEquip: bool
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#func _on_corruption_sword_pressed(): #subtracts coins when the 
									#sword button is pressed 
	#if coins_l == 15:
		#coins_l == 0
#-------------------------------------------------------------------------------
