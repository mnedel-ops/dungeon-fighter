extends Node
const JUMP_VELOCITY = -128-64
@onready var p_2: CharacterBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	animated_sprite_2d.play("Jump")


func _physics_process(delta: float) -> void:
	if not p_2.is_on_floor():
		p_2.velocity += p_2.get_gravity() * delta
	
	if Input.is_action_just_pressed("move-jump") and p_2.is_on_floor():
		p_2.velocity.y = JUMP_VELOCITY
	if p_2.position.y > -10:
		animated_sprite_2d.play("Fall")
	p_2.move_and_slide()
	
