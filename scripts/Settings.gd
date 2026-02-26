#extends Node
#
#@onready var camera_2d = $Player/Camera2D
#@onready var fov_slider = $"FOV Slider"
#@onready var fov_value = $"FOV Slider/FOV Value"
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#slider()
	
#func _process(_delta):
	#slider()
#
#func slider():
	#$camera_2d.fov = $fov_slider.value
	#$fov_slider.text = $fov_slider.value
