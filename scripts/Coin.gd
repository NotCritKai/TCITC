extends Area2D
@onready var game_manager = %GameManager
@onready var pickup_coins_animation = $PickupCoinsAnimation
#main variables 
#-------------------------------------------------------------------------------
func _on_body_entered(_body):
	game_manager.add_point()
	pickup_coins_animation.play("pickup")
	#when player touches coin it adds a point and plays the pickup sound
#-------------------------------------------------------------------------------
