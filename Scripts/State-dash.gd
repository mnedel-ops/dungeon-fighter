extends Node
const SPEED = 64.0
@onready var p_2: CharacterBody2D = $"../.."

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move-left", "move-right")
	if Input.is_action_just_pressed("move-dash"):
		p_2.velocity.x = direction * SPEED * 16
	p_2.move_and_slide()
