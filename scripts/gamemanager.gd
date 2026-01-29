extends Node

var score = 0

@onready var coin_label = $CanvasLayer/CoinLabel

func add_point():
	score += 1
	coin_label.text =str(score) + " 💰"

#BUTTON CODES
func _on_go_to_shop_button_pressed():
	var shop = preload("res://scenes/shop_menu.tscn").instantiate()
	get_tree().paused = true
#BUTTON CODES


