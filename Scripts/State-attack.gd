extends Node

@onready var hit_box: HitBox = $"../../Area2D/HitBox"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
func enter():
	hit_box.set_deferred("disabled", false)
	if animated_sprite_2d.animation != "Attack":
		animated_sprite_2d.play("Attack")
	print_debug("RECEBA")
