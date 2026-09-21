extends Control

@export var arena_select : PackedScene

# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	get_tree().change_scene_to_packed(arena_select)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
