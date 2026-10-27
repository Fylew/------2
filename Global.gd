extends Node



var money: int = 200
var base_max_hp: float = 100.0
var base_hp: float = 100.0
var current_wave: int = 5
var max_waves: int = 5
var is_game_over: bool = false

func reset_run() -> void:
	money = 200
	base_hp = base_max_hp
	current_wave = 1
	is_game_over = false
