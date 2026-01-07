extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -250.0
var coins = 0


@export var maxHealth: int = 100
var currentHealth: int


@export var damageCooldown: float = 1.0
var canTakeDamage: bool = true


var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite: Sprite2D = $Sprite2D


@onready var health_bar: ProgressBar = $CanvasLayer/ProgressBar

func _ready() -> void:
	currentHealth = maxHealth


	health_bar.max_value = maxHealth
	health_bar.value = currentHealth

	print("Player ready with health:", currentHealth)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta


	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")

	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true


	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


#damage system


func take_damage(amount: int) -> void:
	if canTakeDamage:
		currentHealth -= amount
		print("Player took", amount, "damage. Current health:", currentHealth)

		# Update the health bar
		health_bar.value = currentHealth

		if currentHealth <= 0:
			die()

		# Start cooldown
		canTakeDamage = false
		var timer := get_tree().create_timer(damageCooldown)
		timer.timeout.connect(func(): canTakeDamage = true)

func die() -> void:
	print("Player has died!")
