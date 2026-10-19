extends CharacterBody2D
class_name Player
@onready var hit_box: HitBox = $Area2D/HitBox
@onready var area_2d: Area2D = $Area2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
			hit_box.set_deferred("disabled", false)

	else:
		hit_box.set_deferred("disabled", true)
		
