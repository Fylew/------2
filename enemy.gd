extends Node2D



@export  var speed: float = 80.0
var current_hp: float = 20.0

var waypoints: Array[Vector2] = []
var current_waypoint_index: int = 0

func _ready() -> void:
	add_to_group("enemy")
	if waypoints.is_empty():
		for w in get_tree().get_first_node_in_group("waypoint"):
			waypoints.append(w.global_position)


func _physics_process(delta: float) -> void:
	if waypoints.is_empty() or current_waypoint_index >= waypoints.size():
		return
		


	var target_pos = waypoints[current_waypoint_index]
	var dir = (target_pos - global_position).normalized()

	velocity = dir * speed
	move_and_slide()

	if global_position.distance_to(target_pos) < 8.0:
		current_waypoint_index += 1
