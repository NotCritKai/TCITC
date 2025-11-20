extends CharacterBody2D

@export var speed: float = 100.0
@export var patrol_distance: float = 200.0
@export var detection_range: float = 250.0
@export var follow_always: bool = true
@export var player: NodePath
@export var gravity: float = 980.0
@export var damage: int = 10   # Damage dealt to player

var start_position: Vector2
var direction: int = 1
var player_node: Node2D

func _ready() -> void:
	start_position = global_position

	# Safely get the player node if assigned in Inspector
	if player != null and str(player) != "":
		var node := get_node_or_null(player)
		if node:
			player_node = node
		else:
			push_warning("Enemy: Could not find player node at path: " + str(player))
	else:
		push_warning("Enemy: Player path not set in Inspector.")

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += gravity * delta

	# Decide whether to chase or patrol
	if player_node and (follow_always or is_player_in_range()):
		chase_player()
	else:
		patrol()

	# Move using CharacterBody2D's built-in velocity
	move_and_slide()

func patrol() -> void:
	velocity.x = speed * direction
	if abs(global_position.x - start_position.x) > patrol_distance or is_on_wall():
		direction *= -1

func chase_player() -> void:
	var direction_to_player := (player_node.global_position - global_position).normalized()
	velocity.x = direction_to_player.x * speed

func is_player_in_range() -> bool:
	return player_node and global_position.distance_to(player_node.global_position) <= detection_range

# -------------------------
# Damage System
# -------------------------

func _on_Area2D_body_entered(body: Node2D) -> void:
	# Debug print to confirm collision
	print("Enemy collided with:", body.name)

	# Only damage if the body has a take_damage() function
	if body.has_method("take_damage"):
		body.take_damage(damage)
