extends Node

var score = 1

@onready var coin_label = $CanvasLayer2/CoinLabel
@onready var coins_l = $Coins_L
@onready var shop_menu = $"."

func add_point():	
	score += 1
	coin_label.text =str(score) + " Coins"
	shop_menu.coin_label.text =str(score) + " Coins"


#BUTTON CODES
func _on_go_to_shop_button_pressed():
	var shop_scene = load("res://scenes/shop_menu.tscn")#loads thw shop  
	var shop = shop_scene.instantiate()#initiates shop 
	get_tree().current_scene.get_node("GameManager/CanvasLayer2").add_child(shop)
	get_tree().paused = true #pauses
#BUTTON CODE


var playerWeaponEquip: bool
