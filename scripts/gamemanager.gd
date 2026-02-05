extends Node

var score = 1

@onready var coin_label = $CanvasLayer/CoinLabel
@onready var coins_l = $Coins_L

func add_point():	
	score += 1
	coin_label.text =str(score) + " 💰"
	coins_l.text =str(score) + " 💰"

#BUTTON CODES
func _on_go_to_shop_button_pressed():
	var shop_scene = load("res://scenes/shop_menu.tscn")  # ← must match EXACT path
	var shop = shop_scene.instantiate()
	get_tree().current_scene.get_node("GameManager/CanvasLayer2").add_child(shop)
	get_tree().paused = true
	 
	
#BUTTON CODES


