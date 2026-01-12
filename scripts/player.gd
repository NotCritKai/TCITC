extends CharacterBody2D
@onready var animated_sprite_2d = %AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -250.0
var coins = 0


@export var maxHealth: int = 100
var currentHealth: int


@export var damageCooldown: float = 1.0
var canTakeDamage: bool = true


var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite: Sprite2D = $Sprite2D
@onready var death_screen: PackedScene = preload("res://scenes/death_menu.tscn")

@onready var animsprite: AnimatedSprite2D = $AnimatedSprite2D


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
	
	
	#when things are pressed it will play the animation for the player
	if direction == 0: 
		animated_sprite_2d.play("Idle")
	elif Input.is_action_just_pressed("jump"):
		animated_sprite_2d.play("Jumping")
		animated_sprite_2d.play("Walking")
	else: 
		animated_sprite_2d.play("Walking")
	#----------------------------------------------------------------------
#direction
	if direction > 0:
		animsprite.flip_h = false
	elif direction < 0:
		animsprite.flip_h = true


	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


#--------------------------------------------------------------
#damage system


func take_damage(amount: int) -> void:
	if canTakeDamage:
		currentHealth -= amount
		print("Player took", amount, "damage. Current health:", currentHealth)

		#update the health bar
		health_bar.value = currentHealth
		#DEATH SCREEN 
		#----------------
#if players health is under zero, changes to death screen 
		#if currentHealth <= 0:
			#var scene = death_screen.instantiate()
			#get_parent().add_child(scene)
			#scene.position = Vector2(-380, -240)
			#scene.scale = Vector2(0.5, 0.5)
			

func die() -> void:
	print("Player has died!")

