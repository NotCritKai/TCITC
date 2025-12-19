extends Camera2D

var zoom_speed = 0.1 # Adjust for faster/slower zoom
var min_zoom = Vector2(0.2, 0.2) # Minimum zoom level (e.g., 0.2x)
var max_zoom = Vector2(2.0, 2.0) # Maximum zoom level (e.g., 2x)

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		zoom_in()
	elif event.is_action_pressed("zoom_out"):
		zoom_out()

func zoom_in():
	zoom -= Vector2(zoom_speed, zoom_speed)
	zoom = zoom.clamp(min_zoom, max_zoom) # Keep within limits

func zoom_out():
	zoom += Vector2(zoom_speed, zoom_speed)
	zoom = zoom.clamp(min_zoom, max_zoom) # Keep within limits
