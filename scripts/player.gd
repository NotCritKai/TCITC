extends CharacterBody2D
var has_sword: bool = false
@onready var animated_sprite_2d = %AnimatedSprite2D
@onready var sword_sound = $"Sword Sound"
#creates the sword sound variable to it can play
#-------------------------------------------------------------------------------
var SPEED = 200.0
var JUMP_VELOCITY = -250.0
var coins = 0
var weapon_equip: bool
#speed+gravity variables
#-------------------------------------------------------------------------------
@export var maxHealth: int = 100
var currentHealth: int

@export var damageCooldown: float = 1.0
var canTakeDamage: bool = true
#-------------------------------------------------------------------------------
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var death_screen: PackedScene = preload("res://scenes/death_menu.tscn")
#preloads the death sceen for faster overlay
@onready var animsprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var health_bar: ProgressBar = $CanvasLayer/ProgressBar
#Other main variables 
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#Attack variables
var attack_damage: int = 10
var attack_cooldown := false
#------------------------------------------------------------------------------

var comment_test = 2 
	


#-------------------------------------------------------------------------------
func _ready() -> void:
	currentHealth = maxHealth
	weapon_equip = true
	
	health_bar.max_value = maxHealth
	health_bar.value = currentHealth
#player gets health to be damaged later 
#-------------------------------------------------------------------------------




#-------------------------------------------------------------------------------
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")

	#If you press shift the player sprints/speed increases
	if Input.is_action_just_pressed("sprint"):
		SPEED = SPEED * 2
		JUMP_VELOCITY = JUMP_VELOCITY * 1.25
	#If you release shift the player stops sprinting/speed decreases
	if Input.is_action_just_released("sprint"):
		SPEED = SPEED / 2
		JUMP_VELOCITY = JUMP_VELOCITY / 1.25
#-------------------------------------------------------------------------------



#-----------------------------#-------------------------------------------------------------------------------	#Player Anims 
#player animations
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

	elif velocity != Vector2.ZERO: #Youre moving
		if has_sword:#If you have the sword
			animated_sprite_2d.play("sword_walk")#Play the walk animation 
			if (Input.is_action_just_pressed("attack") and Input.is_action_just_pressed("attack")):#If attack is pressed and you have sword play sword attack
				animated_sprite_2d.play("sword_attack_walking")
		elif !has_sword:
			animated_sprite_2d.play("walk") 
#-------------------------------------------------------------------------------
	
	
	
	
	
#-------------------------------------------------------------------------------
	#Flips the player and hitbox when facing diff directions (L and R)
	if direction > 0:
		animsprite.flip_h = false
	elif has_sword:
		$AttackArea.position.x = -abs($AttackArea.position.x)
	if direction < 0:
		animsprite.flip_h = true
	elif has_sword:
		$AttackArea.position.x = abs($AttackArea.position.x)
#-------------------------------------------------------------------------------
		
		
		
#-------------------------------------------------------------------------------
	#direction/movement Code
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if currentHealth == 0:#If players health reaches 0 it changes to Death Scene
		get_tree().change_scene_to_file("res://scenes/death_menu.tscn")
	move_and_slide()#IF THE DIRECTION IS NOT 0 THE ENEMY MOVES FROM SIDE TO SIDE
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
	if Input.is_action_just_pressed("attack") and not attack_cooldown:
		attack()#When you press f it attacks
		sword_sound.play()#when you attack it plays the sound 
#-------------------------------------------------------------------------------




#-------------------------------------------------------------------------------
#damage system enemy-player
func take_damage(amount: int) -> void:
	if canTakeDamage:
		currentHealth -= amount
		print("Player took", amount, "damage. Current health:", currentHealth)
		#prints how much damage was taken 
		health_bar.value = currentHealth #changes the value of health since it was damaged
#-------------------------------------------------------------------------------
	
	
	
	
#-------------------------------------------------------------------------------
#player attack system 
func attack():
	attack_cooldown = true

	#hitbox stuff 
	$AttackArea.monitoring = true
	$AttackArea.monitorable = true
	print("Hitbox ON")

	#Another Hitbox thing...
	await get_tree().create_timer(0.2).timeout

	$AttackArea.monitoring = false
	$AttackArea.monitorable = false
	print("Hitbox OFF")
	#Cooldown prevents it from starting too fast
	await get_tree().create_timer(0.3).timeout
	attack_cooldown = false
#-------------------------------------------------------------------------------	
	
	
	
	
	
#-------------------------------------------------------------------------------
#when the player enters the enemies hitbox theyre damaged.=
func _on_attack_area_body_entered(body):
	if body.has_method("take_damage"):#if the player enters the enemy "body" they are damaged
		body.take_damage(attack_damage)
#-------------------------------------------------------------------------------

