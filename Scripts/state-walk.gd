extends Node
const SPEED = 64.0
@onready var p_2: CharacterBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move-left", "move-right")
	if direction:
		p_2.velocity.x = direction * SPEED
	else:
		p_2.velocity.x = move_toward(p_2.velocity.x, 0, SPEED)
	p_2.move_and_slide()

	if direction != 0:
		if animated_sprite_2d.animation != "Run":
			animated_sprite_2d.play("Run")
		animated_sprite_2d.flip_h = direction < 0
	else:
		if animated_sprite_2d.animation != "Idle": # Change "Idle" to whatever your idle animation is named
			animated_sprite_2d.play("Idle")
