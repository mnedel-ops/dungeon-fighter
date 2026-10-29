extends Node
const SPEED = 32.0
@onready var p_2: CharacterBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var states: Node = $".."

func enter() -> void:
	set_process(true)
	
func _process(delta: float) -> void:
	var direction := Input.get_axis("move-left", "move-right")
	if direction:
		p_2.velocity.x = direction * SPEED
		if animated_sprite_2d.animation != "Walk":
			animated_sprite_2d.play("Walk")
		animated_sprite_2d.flip_h = p_2.velocity.x < 0
	else:
		p_2.velocity.x = move_toward(p_2.velocity.x, 0, SPEED)
		states.change_state(states.get_node("Idle"))
	p_2.move_and_slide()
	
