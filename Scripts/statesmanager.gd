extends Node

var current_state : Node

func _ready() -> void:
	current_state = $Idle
	current_state.enter()
