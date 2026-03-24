extends Button

@export var coins_to_subtract: int = 15

func _ready():
	pressed.connect(_on_pressed)
	
func _on_pressed():
	if Gamemanager.score >= coins_to_subtract:
		Gamemanager.score -= coins_to_subtract
		print(Gamemanager.score)
	else:
		print("Not Enough Coins!")
