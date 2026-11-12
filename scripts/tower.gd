extends Node2D

@export var range_radius: float = 250.0 
@export var fire_rate: float = 1.5 
@export var damage: float = 10.0
@export var bullet_scene: PackedScene 

var target: Node2D = null
var cooldown: float = 0.0

@onready var sprite = $Sprite2D

func _ready() -> void:
	add_to_group("tower") 
	if sprite == null:
		print("нет спрайта")
		
func _process(delta: float) -> void:

	if target == null or not is_instance_valid(target) or global_position.distance_to(target.global_position) > range_radius:
		target = _find_closest_enemy()


	if target:
		var angle = (target.global_position - global_position).angle()
		sprite.rotation = angle + PI / 2 

	# Стреляем
	cooldown -= delta
	if cooldown <= 0 and target != null:
		_shoot()
		cooldown = 1.0 / fire_rate

func _find_closest_enemy() -> Node2D:
	var enemies = get_tree().get_nodes_in_group("enemy")
	var closest: Node2D = null
	var min_dist = range_radius
	
	for e in enemies:
		if not is_instance_valid(e): continue
		var d = global_position.distance_to(e.global_position)
		if d < min_dist:
			min_dist = d
			closest = e
	return closest

func _shoot() -> void:
	if bullet_scene == null or target == null:
		return
		
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	var dir = (target.global_position - global_position).normalized()
	bullet.direction = dir
	bullet.rotation = dir.angle()
	bullet.damage = damage
	get_tree().current_scene.add_child(bullet)
