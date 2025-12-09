extends CharacterBody2D

# -------------------------
# Exported variables (editable in Inspector)
# -------------------------
@export var speed: float = 155.0            # Movement speed
@export var patrol_distance: float = 200.0  # How far the enemy walks before turning around
@export var detection_range: float = 250.0  # How close the player must be before enemy chases
@export var follow_always: bool = true      # If true, enemy always chases player
@export var gravity: float = 980.0          # Gravity force applied to enemy
@export var damage: int = 10                # Damage dealt to player on collision

# -------------------------
# Internal variables
# -------------------------
var start_position: Vector2                 # Starting position (used for patrol distance)
var direction: int = 1                      # Patrol direction (1 = right, -1 = left)
var player_node: Node2D                     # Reference to the player node

# -------------------------
# Setup
# -------------------------
func _ready() -> void:
	# Save the starting position for patrol logic
	start_position = global_position

	# Find the player dynamically using the "player" group
	# (Make sure your Player node is added to the "player" group in the editor)
	player_node = get_tree().get_first_node_in_group("player")

	# Safety check: warn if no player was found
	if player_node == null:
		push_warning("Enemy: No player found in group 'player'")

# -------------------------
# Main physics loop
# -------------------------
func _physics_process(delta: float) -> void:
	# Apply gravity every frame
	velocity.y += gravity * delta

	# Decide whether to chase or patrol
	if player_node and (follow_always or is_player_in_range()):
		chase_player()
	else:
		patrol()

	# Move using CharacterBody2D's built-in velocity system
	move_and_slide()

# -------------------------
# Patrol behavior
# -------------------------
func patrol() -> void:
	# Move left or right depending on direction
	velocity.x = speed * direction

	# If enemy has walked too far from start OR hit a wall, flip direction
	if abs(global_position.x - start_position.x) > patrol_distance or is_on_wall():
		direction *= -1

# -------------------------
# Chase behavior
# -------------------------
func chase_player() -> void:
	# Calculate direction vector toward player
	var direction_to_player := (player_node.global_position - global_position).normalized()

	# Move horizontally toward player
	velocity.x = direction_to_player.x * speed

# -------------------------
# Detection check
# -------------------------
func is_player_in_range() -> bool:
	# Returns true if player is within detection range
	return player_node and global_position.distance_to(player_node.global_position) <= detection_range

# -------------------------
# Damage System
# -------------------------

func _on_area_2d_body_entered(body):
		# Debug print to confirm collision
	print("Enemy collided with:", body.name)

	# Only damage if the body has a take_damage() function (Player does)
	if body.has_method("take_damage"):
		body.take_damage(damage)
