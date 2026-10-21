extends CharacterBody2D
class_name Player
@onready var hit_box: HitBox = $Area2D/HitBox
@onready var area_2d: Area2D = $Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
			hit_box.set_deferred("disabled", false)
			animated_sprite_2d.play("Attack")

	else:
		hit_box.set_deferred("disabled", true)
		animated_sprite_2d.stop()
		
