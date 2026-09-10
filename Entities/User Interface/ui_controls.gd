extends Control
@export var back : Button
@onready var settings: PackedScene = preload("res://Entities/User Interface/ui-settings.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back.pressed.connect(_on_pressed_back)

func _on_pressed_back() -> void:
	get_tree().change_scene_to_packed(settings)
