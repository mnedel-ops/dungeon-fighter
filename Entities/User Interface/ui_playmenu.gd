extends Control

@export var botao : Button
var menu : PackedScene = load("res://Entities/User Interface/ui_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	botao.pressed.connect(_on_pressed)

func _on_pressed():
	get_tree().change_scene_to_packed(menu)
