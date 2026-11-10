extends Node2D

var tower_scene: PackedScene
var price: int
var range_radius: float
var is_valid: bool = false
var has_placed: bool = false


@onready var check_area = $CheckArea
@onready var sprite = $Sprite

func setup(icon: Texture2D, radius: float, cost: int, scene: PackedScene) -> void:
	sprite.texture = icon
	range_radius = radius
	price = cost
	tower_scene = scene

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	
	_check_validity()
	queue_redraw() 

func _check_validity() -> void:
	is_valid = true
	var overlapping = check_area.get_overlapping_areas() + check_area.get_overlapping_bodies()
	for obj in overlapping:
		if obj.is_in_group("tower") or obj.is_in_group("road"): # road пока не сделали, но на будущее
			is_valid = false
			break

func _draw() -> void:

	var color = Color(0.0, 1.0, 0.0, 0.3)
	if not is_valid:
		color = Color(1.0, 0.0, 0.0, 0.3)
	draw_circle(Vector2.ZERO, range_radius, color)

func _unhandled_input(event: InputEvent) -> void:
	if has_placed: return
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			has_placed = true
			if is_valid and Global.money >= price:
				Global.money -= price
				var real_tower = tower_scene.instantiate()
				real_tower.global_position = global_position
				get_tree().current_scene.add_child(real_tower)
			queue_free()
		elif event.button_index == MOUSE_BUTTON_RIGHT and not event.pressed:
			has_placed = true
			queue_free()
