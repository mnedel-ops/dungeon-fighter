
extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_box: CollisionShape2D = $AnimatedSprite2D/Area2D/HitBox

const JUMP_VELOCITY = -256
const SPEED = 32.0
const DASH = 512.0

enum States {IDLE, WALK, JUMP, FALL, DASH, ATTACK}

var state: States = States.IDLE
var is_attacking: bool = false
var is_dashing: bool = false

var sentido := 1

func _ready() -> void:
	animated_sprite_2d.animation_finished.connect(_on_animation_finished)

func _physics_process(delta: float) -> void:
	# Física
	var direction := Input.get_axis("move-left", "move-right")

	if direction:
		animated_sprite_2d.scale.x = direction
		sentido = int(sign(direction))

	velocity.x = direction * SPEED
	velocity += get_gravity() * delta

	# Atualização dos estados de movimentação
	if not is_attacking:

		if Input.is_action_just_pressed("move-jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			state = States.JUMP
		
		if Input.is_action_just_pressed("move-dash"):
			dash()
		
		elif not is_on_floor():
			if velocity.y < 0:
				state = States.JUMP
			else:
				state = States.FALL

		elif velocity.x != 0:
			state = States.WALK

		else:
			state = States.IDLE

		# Ataque
		if Input.is_action_just_pressed("attack"):
			attack()

	# Animação
	if not is_attacking or not is_dashing:
		animation()

	# Movimento
	move_and_slide()

func animation() -> void:
	match state:
		States.IDLE:
			animated_sprite_2d.play("Idle")

		States.WALK:
			animated_sprite_2d.play("Walk")

		States.JUMP:
			animated_sprite_2d.play("Jump")

		States.FALL:
			animated_sprite_2d.play("Fall")

func attack() -> void:
	if is_attacking:
		return

	is_attacking = true
	state = States.ATTACK

	hit_box.set_deferred("disabled", false)
	animated_sprite_2d.play("Att")

func dash() -> void:
	if is_dashing:
		return

	is_dashing = true
	state = States.DASH

	#hit_box.set_deferred("disabled", false)
	animated_sprite_2d.play("Dash")

func _on_animation_finished() -> void:
	if animated_sprite_2d.animation == "Dash":
		is_dashing = false
		
	if animated_sprite_2d.animation == "Att":
		is_attacking = false
		hit_box.set_deferred("disabled", true)
		# Recupera o estado de movimentação
		if not is_on_floor():
			if velocity.y < 0:
				state = States.JUMP
			else:
				state = States.FALL

		elif velocity.x != 0:
			state = States.WALK

		else:
			state = States.IDLE
