
extends CharacterBody2D
class_name Boss

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player: Player = get_tree().current_scene.get_node("Player") #pega o node da arvore

const JUMP_VELOCITY = -256
const SPEED = 16.0
const FLEE_SPEED = SPEED * 2

const SAFE_DISTANCE : float = 64.00
const DANGER_DISTANCE : float = SAFE_DISTANCE/2
enum States {IDLE, WALK, JUMP, FALL, ATTACK, FLEE}

var state: States = States.IDLE
@onready var ataque_raiz: Node2D = $Node2D

var direction : int = 1
var old_direction :int = direction

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	# Estados
	if position.distance_to(player.position) > SAFE_DISTANCE:
		state = States.WALK
	else: state = States.IDLE
	
	if position.distance_to(player.position) < DANGER_DISTANCE:
		state = States.FLEE
	
	if position.distance_to(player.position) > 10:
		move_and_slide()
	if state == States.FLEE and velocity.x == 0:
		if direction > 0:
			position.x = player.position.x - SAFE_DISTANCE
		elif direction < 0:
			position.x = player.position.x + SAFE_DISTANCE
#	Controlar o sentido do Boss
	if position.x > player.position.x:
		direction = 1
	elif position.x < player.position.x:
		direction = -1
		
	if direction != old_direction:
		print(direction)
		old_direction = direction
		scale.x = direction
		
	match state:
		States.IDLE: idle()
		States.WALK: walk()
		States.FLEE: flee()
		
func idle():
	velocity = Vector2.ZERO
	
func walk():
	velocity = position.direction_to(player.position) * SPEED
	velocity.y = 0
	
func flee():
	velocity = -position.direction_to(player.position) * FLEE_SPEED
func animation() -> void:
	pass
