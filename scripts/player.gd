extends CharacterBody2D
@onready var animated_sprite_2d = %AnimatedSprite2D

var SPEED = 200.0
const JUMP_VELOCITY = -250.0
var coins = 0
var weapon_equip: bool

@export var maxHealth: int = 100
var currentHealth: int

@export var damageCooldown: float = 1.0
var canTakeDamage: bool = true

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite: Sprite2D = $Sprite2D
@onready var death_screen: PackedScene = preload("res://scenes/death_menu.tscn")

@onready var animsprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var health_bar: ProgressBar = $CanvasLayer/ProgressBar

# -----------------------------
# NEW: Attack variables
# -----------------------------
var attack_damage: int = 10
var attack_cooldown := false
# -----------------------------


func _ready() -> void:
	currentHealth = maxHealth
	weapon_equip = true

	health_bar.max_value = maxHealth
	health_bar.value = currentHealth

	print("Player ready with health:", currentHealth)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")

	# Sprint
	if Input.is_action_just_pressed("sprint"):
		SPEED = SPEED * 2
	if Input.is_action_just_released("sprint"):
		SPEED = SPEED / 2

	# Animations
	if !velocity:
		animated_sprite_2d.play("idle")
	elif Input.is_action_just_pressed("jump"):
		animated_sprite_2d.play("jump")
		animated_sprite_2d.play("walk")
	elif velocity:
		animated_sprite_2d.play("walk")

	# Flip sprite
	if direction > 0:
		animsprite.flip_h = false
		$AttackArea.position.x = abs($AttackArea.position.x)
	elif direction < 0:
		animsprite.flip_h = true
		$AttackArea.position.x = -abs($AttackArea.position.x)

	# Movement
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Death
	if currentHealth == 0:
		get_tree().change_scene_to_file("res://scenes/death_menu.tscn")

	move_and_slide()

	# -----------------------------
	# NEW: Attack input
	# -----------------------------
	if Input.is_action_just_pressed("attack") and not attack_cooldown:
		attack()
	# -----------------------------


# --------------------------------------------------------------
# DAMAGE SYSTEM (Player takes damage)
# --------------------------------------------------------------
func take_damage(amount: int) -> void:
	if canTakeDamage:
		currentHealth -= amount
		print("Player took", amount, "damage. Current health:", currentHealth)

		health_bar.value = currentHealth


#player_attacking
func attack():
	attack_cooldown = true

	# Turn on hitbox
	$AttackArea.monitoring = true
	$AttackArea.monitorable = true
	print("Hitbox ON")

	# Hitbox active for 0.2 seconds
	await get_tree().create_timer(0.2).timeout

	# Turn off hitbox
	$AttackArea.monitoring = false
	$AttackArea.monitorable = false
	print("Hitbox OFF")
	# Small cooldown to prevent spam
	await get_tree().create_timer(0.3).timeout
	attack_cooldown = false


# --------------------------------------------------------------
# NEW: Attack Hitbox Signal
# --------------------------------------------------------------
func _on_attack_area_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(attack_damage)
