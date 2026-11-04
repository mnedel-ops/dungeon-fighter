extends Node

@onready var hit_box: HitBox = $"../../Area2D/HitBox"
@export var anim_play: AnimatedSprite2D

func enter() -> void:
	hit_box.set_deferred("disabled", false)
	anim_play.play("Att")
	print_debug("RECEBA")
