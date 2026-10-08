extends Control

@export var match_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		get_tree().change_scene_to_packed(match_scene)
