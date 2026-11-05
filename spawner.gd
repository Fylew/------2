extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 1.5
@export var enemies_per_wave: int = 5

var waypoints: Array[Vector2] = []
var timer: Timer 
var enemies_to_spawn: int = 0

func _ready() -> void:
	for w in get_tree().get_nodes_in_group("waypoint"):
		waypoints.append(w.global_position)
		
	if waypoints.is_empty():
		print("ОШИБКА ЛОЛ КЕК ЧЕБУРЕК ТОЧКИ ВЫШЛИ ИЗ ЧАТА")
		return

	timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(timer)
	
	await get_tree().create_timer(2.0).timeout
	start_wave()

func start_wave() -> void:
	print('на нас напали школники', Global.current_wave)
	enemies_to_spawn = enemies_per_wave * Global.current_wave
	timer.start()
	
func _on_spawn_timer_timeout() -> void:
	if enemies_to_spawn <= 0:
		timer.stop()
		return
	
	var enemy = enemy_scene.instantiate()
	enemy.global_position = waypoints[0]
	enemy.waypoints = waypoints
	get_tree().current_scene.add_child(enemy)
	
	enemies_to_spawn -= 1 
