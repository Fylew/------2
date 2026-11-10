extends Area2D


@export var demage_per_enemy: float = 10.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		Global.base_hp -= demage_per_enemy
		print("ай больно в ноге .осталось хп:",Global.base_hp)
		body.queue_free()
		if Global.base_hp <= 0:
			_game_over()

func _game_over() -> void:
	if Global.is_game_over: return
	Global.is_game_over = true
	print("ТЫ ЗДОХ")
	get_tree().change_scene_to_file("res://menu.tscn")
