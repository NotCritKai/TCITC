extends CharacterBody2D
var has_sword: bool = false
@onready var animated_sprite_2d = %AnimatedSprite2D
@onready var sword_sound = $"Sword Sound"


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



func _ready() -> void:
	currentHealth = maxHealth
	weapon_equip = true

	health_bar.max_value = maxHealth
	health_bar.value = currentHealth

	print("Player ready with health:", currentHealth)#DEBUG


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")

	#If you press shift the player sprints
	if Input.is_action_just_pressed("sprint"):
		SPEED = SPEED * 2
	if Input.is_action_just_released("sprint"):
		SPEED = SPEED / 2



	#Player Anims #ADD THE OTHER ANIMATIONS
	if velocity == Vector2.ZERO: #If not moving it will play idle 
		if has_sword and Input.is_action_just_pressed("attack"):
			animated_sprite_2d.play("sword_attack")
		elif !has_sword:
			animated_sprite_2d.play("idle")
	elif Input.is_action_just_pressed("jump"): #If space is pressed play jump anim 
		if has_sword:
			animated_sprite_2d.play("sword_jump")
		elif !has_sword:
			animated_sprite_2d.play("jump")

	elif velocity != Vector2.ZERO:
		if has_sword:
			animated_sprite_2d.play("sword_walk")
		elif !has_sword:
			animated_sprite_2d.play("walk")
			
			
		
	#Player Anims #ADD THE OTHER ANIMATIONS
	
	
	
	
	#Flips the sprite + Hitbox when facing diff directions (L and R)
	if direction > 0:
		animsprite.flip_h = false
	elif has_sword:
		$AttackArea.position.x = -abs($AttackArea.position.x)
	if direction < 0:
		animsprite.flip_h = true
	elif has_sword:
		$AttackArea.position.x = abs($AttackArea.position.x)

	#Direction/Movement Code
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
	if currentHealth == 0:#If players health reaches 0 it changes to Death Scene
		get_tree().change_scene_to_file("res://scenes/death_menu.tscn")

	move_and_slide()

	#-----------------------------
	if Input.is_action_just_pressed("attack") and not attack_cooldown:
<<<<<<< Updated upstream
		attack()#When you press f it attacks
=======
		attack()#attack input
		sword_sound.play()
		
>>>>>>> Stashed changes
	# -----------------------------




	#--------------------------------------------------------------
#damage_system (Player takes damage)

func take_damage(amount: int) -> void:
	if canTakeDamage:
		currentHealth -= amount
		print("Player took", amount, "damage. Current health:", currentHealth)

		health_bar.value = currentHealth
	#--------------------------------------------------------------





#player_attacking
func attack():
	attack_cooldown = true

	#hitbox stuff 
	$AttackArea.monitoring = true
	$AttackArea.monitorable = true
	print("Hitbox ON")

	#Another Hitbox thinggggggggggg......
	await get_tree().create_timer(0.2).timeout

	$AttackArea.monitoring = false
	$AttackArea.monitorable = false
	print("Hitbox OFF")
	#Cooldown prevents it from starting too fast
	await get_tree().create_timer(0.3).timeout
	attack_cooldown = false
	# --------------------------------------------------------------
#attack hitbox thing
func _on_attack_area_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(attack_damage)
	# --------------------------------------------------------------

