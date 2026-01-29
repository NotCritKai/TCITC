extends Area2D

@onready var game_manager = %GameManager
@onready var pickup_coins_animation = $PickupCoinsAnimation
@onready var coins_l = $Coins_L


func _on_body_entered(_body):
	game_manager.add_point()
	pickup_coins_animation.play("pickup")

