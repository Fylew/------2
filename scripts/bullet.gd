extends Area2D

@export var speed:float = 500.0
var damage: float = 10.0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	var t = Timer.new()
	t.wait_time = 2.0
	t.one_shot = true
	t.timeout.connect(queue_free)
	add_child(t)
	t.start()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta



func _on_body_entered(body: Node2D) -> void:
	if body.has_method('take_damage'):
		body.take_damage(damage)
	queue_free()
