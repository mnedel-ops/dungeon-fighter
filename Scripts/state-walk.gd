extends Node
const SPEED = 64.0
@onready var p_2: CharacterBody2D = $"../.."

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move-left", "move-right")
	if direction:
		p_2.velocity.x = direction * SPEED
	else:
		p_2.velocity.x = move_toward(p_2.velocity.x, 0, SPEED)
	p_2.move_and_slide()
