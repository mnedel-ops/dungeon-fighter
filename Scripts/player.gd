extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const JUMP_VELOCITY = -256
const SPEED = 32.0
const DASH = 512.0

enum States {IDLE, WALK, JUMP, FALL, DASH, ATTACK}
var is_attacking : bool= false
var state :States= States.IDLE

var sentido := 1

func _physics_process(delta: float) -> void:
	#Gravidade
	var direction := Input.get_axis("move-left", "move-right")
	if direction:
		animated_sprite_2d.scale.x = direction
		sentido = direction as int
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
		animation()

	if Input.is_action_just_pressed("move-dash"): 
		state = States.DASH
	
	elif (state == States.WALK and velocity.x==0) or (state == States.FALL and is_on_floor()): #Se tava andando e para ou caindo e toca no piso
		state = States.IDLE

	#if state != States.ATTACK: 
		#$AnimatedSprite2D/Area2D/HitBox.disabled = true
	if state != States.DASH: 
		$AnimatedSprite2D/Area2D/PainBox.disabled = false
	animation()
	move_and_slide()

func animation():
	if state == States.ATTACK:
		animated_sprite_2d.play("Att")
		$AnimatedSprite2D/Area2D/HitBox.disabled = false
	$AnimatedSprite2D/Area2D/HitBox.disabled = true
	if state == States.WALK:
		animated_sprite_2d.play("Walk")
	if state == States.IDLE:
		animated_sprite_2d.play("Idle")
	if state == States.JUMP:
		animated_sprite_2d.play("Jump")
		velocity.y = JUMP_VELOCITY
	if state == States.FALL:
		animated_sprite_2d.play("Fall")
	
func attack():
	if is_attacking:
		return
	is_attacking = true

func dash():
	velocity.x += DASH * sentido
	animated_sprite_2d.play("Dash")
	state = States.IDLE
	$AnimatedSprite2D/Area2D/PainBox.disabled = true
