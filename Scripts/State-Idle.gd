extends Node
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var p_2: CharacterBody2D = $"../.."

func enter() -> void:
	animated_sprite_2d.play("Idle")
	p_2.velocity.x = 0
