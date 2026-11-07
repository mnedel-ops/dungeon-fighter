extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const JUMP_VELOCITY = -256
const SPEED = 32.0

enum States {IDLE, WALK, JUMP, FALL}
var state :States= States.IDLE

func _physics_process(delta: float) -> void:
	#Gravidade
	velocity += get_gravity() * delta
	
	#Movimetno
	var direction := Input.get_axis("move-left", "move-right")
	if direction:
		state = States.WALK
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = velocity.x < 0

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		state = States.IDLE
	
	#Pular
	if Input.is_action_pressed("move-jump") and is_on_floor():
		state = States.JUMP
	move_and_slide()
	
	if state == States.IDLE:
		animated_sprite_2d.play("Idle")

	if state == States.JUMP:
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("Jump")
		print(velocity.y)
		
	elif state==States.JUMP and velocity.y > 0.0:
		state = States.FALL
		
	if state == States.FALL:
		animated_sprite_2d.play("Fall")

	if state == States.WALK:
		animated_sprite_2d.play("Walk")
