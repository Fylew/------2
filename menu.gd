extends Control

func _on_play_button_pressed() -> void:
	Global.reset_run()
	get_tree().change_scene_to_file("res://game.tscn")
