extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const JUMP_VELOCITY = -256
const SPEED = 32.0
const DASH = 64

enum States {IDLE, WALK, JUMP, FALL, ATTACK, DASH}
var state :States= States.IDLE

func _physics_process(delta: float) -> void:
	#Gravidade
	var direction := Input.get_axis("move-left", "move-right")
	velocity.x = direction * SPEED
	velocity += get_gravity() * delta
	
	if Input.is_action_pressed("move-jump") and is_on_floor():
		state = States.JUMP
	
	elif velocity.x:
		state = States.WALK
	
	if velocity.y <= 0:
		state = States.FALL

	if Input.is_action_just_pressed("attack"):
		state = States.ATTACK

	if Input.is_action_just_pressed("move-dash"): 
		state = States.DASH
	
	elif (state == States.WALK and velocity.x==0) or (state == States.FALL and is_on_floor()): #Se tava andando e para ou caindo e toca no piso
		state = States.IDLE

	match state:
		States.IDLE: idle()
		States.WALK: walk()
		States.JUMP: jump()
		States.FALL: fall()
		States.ATTACK: attack()
		States.DASH: dash()
		
	move_and_slide()
	

var sentido := 1
func walk():
	animated_sprite_2d.play("Walk")
	animated_sprite_2d.flip_h = velocity.x < 0
	if animated_sprite_2d.flip_h:
		sentido = -1
	else: sentido = 1


func idle():
	velocity.x = 0
	animated_sprite_2d.play("Idle")

func jump():
	animated_sprite_2d.play("Jump")
	velocity.y = JUMP_VELOCITY
	
func fall():
	animated_sprite_2d.play("Fall")
	
func attack():
	animated_sprite_2d.play("Att")

func dash():
	velocity.x += DASH * sentido
	animated_sprite_2d.play("Dash")
	state = States.IDLE
	
