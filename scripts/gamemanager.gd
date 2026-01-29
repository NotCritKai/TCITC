extends Node

var score = 1

@onready var coin_label = $CanvasLayer/CoinLabel
@onready var coins_l = $Coins_L

func add_point():
	score += 1
	coin_label.text =str(score) + " 💰"
	coins_l.text =str(score) + " 💰"
	
func _ready():
	if score > 0:
		coins_l.text =score + str(" 💰")
#BUTTON CODES
func _on_go_to_shop_button_pressed():
		get_tree().change_scene_to_file("res://scenes/shop_menu.tscn")
	
#BUTTON CODES


