
extends CharacterBody2D
class_name Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var hit_box: CollisionShape2D = $Axe/Hitbox/HitBox

@onready var sprite_2d: Sprite2D = $Player
@onready var axe: Sprite2D = $Axe

const JUMP_VELOCITY = -256 - 32
const SPEED = 32.0

const DASH_DISTANCE := 48.0
const DASH_DURATION := 0.18
const DASH_SPEED := DASH_DISTANCE / DASH_DURATION

var dash_timer := 0.0

enum States {IDLE, WALK, JUMP, FALL, DASH, ATTACK}

var state: States = States.IDLE
var is_attacking: bool = false
var is_dashing: bool = false

var sentido := 1

func _ready() -> void:
	hit_box.set_deferred("disabled", true)

func _physics_process(delta: float) -> void:
	# Física
	var direction := Input.get_axis("move-left", "move-right")

	if direction:
		sprite_2d.scale.x = direction
		axe.scale.x = direction
		sentido = int(sign(direction))

	velocity.x = direction * SPEED
	velocity += get_gravity() * delta

	# Atualização dos estados de movimentação
	if not is_attacking and not is_dashing:

		if Input.is_action_just_pressed("move-jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			state = States.JUMP
				
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
		if Input.is_action_just_pressed("move-dash"):
			dash()

	# Animação
	if not is_attacking and not is_dashing:
		animation()
	if is_dashing:
		velocity.x = DASH_SPEED * sentido
		velocity.y = 0

		dash_timer -= delta

		if dash_timer <= 0:
			is_dashing = false
			velocity.x = 0
	else:
			velocity.x = direction * SPEED
	# Movimento
	move_and_slide()

func animation() -> void:
	match state:
		States.IDLE:
			animation_player.play("Idle")

		States.WALK:
			animation_player.play("walk")

		States.JUMP:
			animation_player.play("Jump")

		States.FALL:
			animation_player.play("Fall")

func attack() -> void:
	if is_attacking:
		return

	is_attacking = true
	state = States.ATTACK

	hit_box.set_deferred("disabled", false)
	animation_player.play("Ataque")
	
func dash() -> void:
	if is_dashing:
		return

	is_dashing = true
	state = States.DASH
	animation_player.play("Dash")
	dash_timer = DASH_DURATION

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Dash":
		is_dashing = false
		
	if anim_name == "Ataque":
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


	pass # Replace with function body.
