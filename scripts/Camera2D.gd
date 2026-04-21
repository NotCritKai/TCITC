extends Camera2D
var zoom_speed = 0.1 #adjusts zoom speed
var min_zoom = Vector2(0.2, 0.2) #min zoom level
var max_zoom = Vector2(2.0, 2.0) #max zoom level 
#main variables like camera zoom + in and out
#-------------------------------------------------------------------------------
func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		zoom_in()
	elif event.is_action_pressed("zoom_out"):
		zoom_out()
#if the mousewheel is scrolled it zooms
#-------------------------------------------------------------------------------
func zoom_in():
	zoom += Vector2(zoom_speed, zoom_speed)
	zoom = zoom.clamp(min_zoom, max_zoom) 
#zoom in function
#-------------------------------------------------------------------------------
func zoom_out():
	zoom -= Vector2(zoom_speed, zoom_speed)
	zoom = zoom.clamp(min_zoom, max_zoom)
#zoom out function 
#-------------------------------------------------------------------------------
