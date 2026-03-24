extends CharacterBody2D
@export var speed: float = 155.0
@export var patrol_distance: float = 200.0
@export var detection_range: float = 250.0
@export var follow_always: bool = true
@export var gravity: float = 980.0
@export var damage: int = 25
#main variables
#-------------------------------------------------------------------------------
#enemy health
@export var max_health: int = 50
var current_health: int = 50
#-------------------------------------------------------------------------------
var start_position: Vector2
var direction: int = 1
var player_node: Node2D
#-------------------------------------------------------------------------------
func _ready() -> void:
	start_position = global_position
	player_node = get_tree().get_first_node_in_group("player")
	current_health = max_health#creates player variable and their health
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	if player_node and (follow_always or is_player_in_range()):
		chase_player()
	else:
		patrol()

	move_and_slide()
#if player is in range then the enemy with follow side to side
#-------------------------------------------------------------------------------
	
	
#-------------------------------------------------------------------------------
#patroling code
func patrol() -> void:
	velocity.x = speed * direction

	if abs(global_position.x - start_position.x) > patrol_distance or is_on_wall():
		direction *= -1
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
func chase_player() -> void:
	var direction_to_player := (player_node.global_position - global_position).normalized()
	velocity.x = direction_to_player.x * speed
	#chases player with speed 
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
func is_player_in_range() -> bool:
	return player_node and global_position.distance_to(player_node.global_position) <= detection_range
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#enemy_damages_player_on_collision
func _on_area_2d_body_entered(body):
	print("Enemy collided with:", body.name) #when enemy hits player it prints
	if body.has_method("take_damage"):
		#deals damage to the player when body has been breached
		body.take_damage(damage)
#-------------------------------------------------------------------------------	

		
#-------------------------------------------------------------------------------
#enemy takes damage 
func take_damage(amount: int) -> void:
	current_health -= amount
	print("Enemy took", amount, "damage. Health:", current_health)#prints enemy damage

	if current_health <= 0:
		die()#if the enemy has health below zero it calls die()
#-------------------------------------------------------------------------------
	
#-------------------------------------------------------------------------------
func die():#When enenmy dies it prints it died and makes it disappear 
	print("Enemy died")
	queue_free()
	visible = false 
#-------------------------------------------------------------------------------
	
