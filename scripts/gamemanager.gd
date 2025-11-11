extends Node

var score = 0

@onready var coin_label = $CanvasLayer/CoinLabel

func add_point():
	score += 1
	coin_label.text =str(score) + " 💰"
