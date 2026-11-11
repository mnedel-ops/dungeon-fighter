extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const JUMP_VELOCITY = -256
const SPEED = 32.0

enum States {IDLE, WALK, JUMP, FALL, ATTACK}
var state :States= States.IDLE

func _physics_process(delta: float) -> void:
	#Gravidade
	var direction := Input.get_axis("move-left", "move-right")
	velocity.x = direction * SPEED
	velocity += get_gravity() * delta
	
	if Input.is_action_pressed("move-jump") and is_on_floor():
		state = States.JUMP
	
	elif Input.is_action_pressed("move-left") or Input.is_action_pressed("move-right"):
		state = States.WALK
	
	if velocity.y <= 0:
		state = States.FALL

	if Input.is_action_just_pressed("attack"):
		print_debug("receba")
		state = States.ATTACK
	
	if (Input.is_action_just_released("move-left") or Input.is_action_just_released("move-right")) or (state == States.FALL and is_on_floor()):
		state = States.IDLE

	match state:
		States.IDLE: idle()
		States.JUMP: jump()
		States.WALK: walk()
		States.FALL: fall()
		States.ATTACK: attack()
	move_and_slide()
	

func walk():
	animated_sprite_2d.play("Walk")
	animated_sprite_2d.flip_h = velocity.x < 0

func idle():
	velocity = Vector2.ZERO
	animated_sprite_2d.play("Idle")

func jump():
	animated_sprite_2d.play("Jump")
	velocity.y = JUMP_VELOCITY
func fall():
	print(str(velocity))
	animated_sprite_2d.play("Fall")
func attack():
	animated_sprite_2d.play("Att")
