
extends CharacterBody2D
class_name Boss

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player: Player = get_tree().current_scene.get_node("P2") #pega o node da arvore

const JUMP_VELOCITY = -256
const SPEED = 16.0
const FLEE_SPEED = SPEED * 2

const SAFE_DISTANCE : float = 64.00
const DANGER_DISTANCE : float = SAFE_DISTANCE/2
enum States {IDLE, WALK, JUMP, FALL, ATTACK, FLEE}

var state: States = States.IDLE
var is_attacking: bool = false

var sentido := 1

var stare : bool = false
func _physics_process(delta: float) -> void:
#	Controlar o sentido do Boss
	if velocity.x < 0 and stare == false:
		sprite_2d.flip_h = false
		stare = true
	elif velocity.x > 0 and stare == true:
		sprite_2d.flip_h = true
		stare = false
		
	# Física
	if position.distance_to(player.position) > SAFE_DISTANCE:
		state = States.WALK
	else: state = States.IDLE
	
	if position.distance_to(player.position) < DANGER_DISTANCE:
		state = States.FLEE
	velocity.y = 0
	
	if position.distance_to(player.position) > 10:
		move_and_slide()
	
	match state:
		States.IDLE: idle()
		States.WALK: walk()
		States.FLEE: flee()
		
func idle():
	velocity = Vector2.ZERO
	
func walk():
	velocity = position.direction_to(player.position) * SPEED
	
func flee():
	velocity = -position.direction_to(player.position) * FLEE_SPEED
func animation() -> void:
	pass
