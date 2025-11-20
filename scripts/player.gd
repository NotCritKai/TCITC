extends CharacterBody2D

const SPEED = 225.0
const JUMP_VELOCITY = -250.0
var coins = 0

# Health
@export var maxHealth: int = 100
var currentHealth: int
signal healthChanged

# Damage cooldown (so you don’t take damage every frame)
@export var damageCooldown: float = 1.0
var canTakeDamage: bool = true

# Gravity
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	# Initialize health at start
	currentHealth = maxHealth
	emit_signal("healthChanged", currentHealth)
	print("Player ready with health:", currentHealth)

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, or 1
	var direction := Input.get_axis("move_left", "move_right")

	# Flip sprite
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

	# Apply direction
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# -------------------------
# Damage System
# -------------------------

func take_damage(amount: int) -> void:
	if canTakeDamage:
		currentHealth -= amount
		emit_signal("healthChanged", currentHealth)
		print("Player health:", currentHealth)

		if currentHealth <= 0:
			die()

		# Start cooldown so damage isn’t applied every frame
		canTakeDamage = false
		# Use a timer to reset damage flag
		var timer := get_tree().create_timer(damageCooldown)
		timer.timeout.connect(func():
			canTakeDamage = true)

func die() -> void:
	print("Player has died!")
	# Add respawn or game over logic here
