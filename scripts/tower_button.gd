extends VBoxContainer


@export var tower_scene: PackedScene
@export var ghost_scene: PackedScene 
@export var tower_icon: Texture2D
@export var price: int = 50
@export var range_radius: float = 250.0

func _ready() -> void:
	$Icon.texture = tower_icon
	$PriceLabel.text = str(price) + "$"



func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed:
		if Global.money >= price:
			var ghost = ghost_scene.instantiate()
			get_tree().current_scene.add_child(ghost)
			ghost.setup(tower_icon, range_radius, price, tower_scene)
