extends Control

func _ready():
	$CanvasLayer.visible = false

#BUTTON CODES
func _on_return_button_pressed():
	get_tree().paused = false 
	queue_free()
	
#BUTTON CODES
