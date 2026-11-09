extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const JUMP_VELOCITY = -128
const SPEED = 32.0

enum States {IDLE, WALK, JUMP, FALL}
var state :States= States.IDLE

func _physics_process(delta: float) -> void:
	#Gravidade
	velocity += get_gravity() * delta
	var direction := Input.get_axis("move-left", "move-right")
	
	if Input.is_action_pressed("move-jump") and is_on_floor():
		state = States.JUMP
		
	
	elif Input.is_action_just_pressed("move-left") or Input.is_action_just_pressed("move-right"):
		animated_sprite_2d.play("Walk")
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = velocity.x < 0
		state = States.WALK

	match state:
		States.IDLE: idle()
		States.JUMP: jump()

	if state == States.JUMP and velocity.y >= 0:
		state = States.FALL
		animated_sprite_2d.play("Fall")
		

		
	if Input.is_action_just_pressed("attack"):
		animated_sprite_2d.play("Att")

	move_and_slide()

func idle():
	animated_sprite_2d.play("Idle")
	velocity = Vector2.ZERO

func jump():
	animated_sprite_2d.play("Jump")
	velocity.y = JUMP_VELOCITY
	print_debug("Pulei")
