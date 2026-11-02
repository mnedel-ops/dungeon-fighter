extends Node

@onready var hit_box: HitBox = $"../../Area2D/HitBox"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter() -> void:
	hit_box.set_deferred("disabled", false)
	animated_sprite_2d.play("Attacks")
	print_debug("RECEBA")
