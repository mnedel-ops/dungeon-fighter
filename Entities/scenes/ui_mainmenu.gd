extends Control

@export var botao : Button
@export var menu : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	botao.pressed.connect(_on_pressed)

func _on_pressed():
	get_tree().change_scene_to_packed(menu)
