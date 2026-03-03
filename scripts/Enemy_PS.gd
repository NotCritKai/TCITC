extends CharacterBody2D

@export var speed: float = 155.0
@export var patrol_distance: float = 200.0
@export var detection_range: float = 250.0
@export var follow_always: bool = true
@export var gravity: float = 980.0
@export var damage: int = 25

# -------------------------
#enemy_health
@export var max_health: int = 50
var current_health: int = 50
# -------------------------

var start_position: Vector2
var direction: int = 1
var player_node: Node2D


func _ready() -> void:
	start_position = global_position
	player_node = get_tree().get_first_node_in_group("player")

	if player_node == null:
		push_warning("Enemy: No player found in group 'player'")

	current_health = max_health


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	if player_node and (follow_always or is_player_in_range()):
		chase_player()
	else:
		patrol()

	move_and_slide()

#direction_code
func patrol() -> void:
	velocity.x = speed * direction

	if abs(global_position.x - start_position.x) > patrol_distance or is_on_wall():
		direction *= -1


func chase_player() -> void:
	var direction_to_player := (player_node.global_position - global_position).normalized()
	velocity.x = direction_to_player.x * speed


func is_player_in_range() -> bool:
	return player_node and global_position.distance_to(player_node.global_position) <= detection_range


# --------------------------------------------------------------
#enemy_damages_player_on_collision

func _on_area_2d_body_entered(body):
	print("Enemy collided with:", body.name)

	if body.has_method("take_damage"):
		body.take_damage(damage)
# --------------------------------------------------------------
#enemy_takes_damage_from_player

func take_damage(amount: int) -> void:
	current_health -= amount
	print("Enemy took", amount, "damage. Health:", current_health)

	if current_health <= 0:
		die()

func die():
	print("Enemy died")
	queue_free()
	visible = false 

