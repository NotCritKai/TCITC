extends ProgressBar

# Called when Player emits the healthChanged signal
func update(new_health: int) -> void:
	value = new_health   # sets the bar’s value to match Player’s health
	print("Health bar updated to:", new_health)
