extends CharacterBody2D

	
const SPEED = 225.0
const JUMP_VELOCITY = -250.0
var coins = 0

const DASH_SPEED = 500.0
const DASH_TIME = 0.2

var atttack_type: String
var current_attack = false 
	
var is_dashing = false
var dash_timer = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $Sprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Get the input direction: -1, 0, or 1
	var direction = Input.get_axis("move_left", "move_right")
	
	#Flips sprite
	if direction > 0:
		sprite.flip_h = false
	
	elif direction < 0:
		sprite.flip_h = true
	
	#Applies direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

