extends Area2D
#-------------------------------------------------------------------------------
@onready var timer = $Timer
#-------------------------------------------------------------------------------
func _on_body_entered(_body):
	print("You Died!")#prints that the player died
	timer.start()
#-------------------------------------------------------------------------------
#When the timer is changed due to damage taken it will switch to the death scene
func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/death_menu.tscn")
#-------------------------------------------------------------------------------
