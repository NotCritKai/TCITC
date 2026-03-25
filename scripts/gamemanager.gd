extends Node

var score = 1

@onready var coin_label = $CanvasLayer2/CoinLabel
@onready var coins_l = $Coins_L
@onready var shop_menu = $"."
#main variables
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
func _on_win_button_pressed():
	get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
#-------------------------------------------------------------------------------
	
func add_point():
	score += 1
	coin_label.text = str(score) + " Coin(s)"
	shop_menu.coin_label.text = str(score) + " Coin(s)"

func subtract_point():
	score -= 15
	coin_label.text = str(score) + " Coin(s)"
	shop_menu.coin_label.text = str(score) + " Coin(s)"
#-------------------------------------------------------------------------------
#Subtract COINS test
#signal score_changed(new_amount: int)


#func subtract_coins(amount: int) -> bool:
	#if score>= amount:
		#score -= amount
		#score_changed.emit(score)
		#return true 
	#return false
