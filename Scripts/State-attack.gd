extends Node

@onready var hit_box: HitBox = $"../../Area2D/HitBox"
@export var anim_play: AnimatedSprite2D
@onready var movement_states: Node = $".."

func enter() -> void:
	hit_box.set_deferred("disabled", false)
	anim_play.play("Att")
	print_debug("RECEBA")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	movement_states.exit()
	
