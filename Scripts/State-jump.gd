extends Node
const JUMP_VELOCITY = -128-64
@onready var p_2: CharacterBody2D = $"../.."

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not p_2.is_on_floor():
		p_2.velocity += p_2.get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move-jump") and p_2.is_on_floor():
		p_2.velocity.y = JUMP_VELOCITY
	p_2.move_and_slide()
