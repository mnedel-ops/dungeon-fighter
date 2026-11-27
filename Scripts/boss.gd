extends CharacterBody2D
class_name Boss

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player: Player = get_tree().current_scene.get_node("Player") #pega o node da arvore

const JUMP_VELOCITY = -256
const SPEED = 16.0
const FLEE_SPEED = SPEED * 2

const SAFE_DISTANCE : float = 64.00
const DANGER_DISTANCE : float = SAFE_DISTANCE/2

enum States {IDLE, WALK, JUMP, FALL, FLEE, TELEPORT, MANUP}
enum Action_States {NONE, ATTACK, INTELLECT_EAT, SMART_BEAN}

var act_state: Action_States = Action_States.NONE
var act_state_last: Action_States = act_state

var state: States = States.IDLE
var state_last :States= state
@onready var hit_box: CollisionShape2D = $Node2D/HitBox/HitBox

@onready var label: Label = $Label

var direction : int = 1
var old_direction :int = direction


#Sortear o estado de fuga e de ataque
#var states = [State.Idle, State.Walk, State.Attack]
#var next_state = states.pick_random()   
func _ready() -> void:
	hit_box.set_deferred("disabled", true)
func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	label.text = States.find_key(state_last) # Output: "RUN"
	#print(States.find_key(state_last))


	# Estados
	if position.distance_to(player.position) > SAFE_DISTANCE:
		state = States.WALK
	elif position.distance_to(player.position) < SAFE_DISTANCE and position.distance_to(player.position) > DANGER_DISTANCE:
		state = States.FLEE
	elif position.distance_to(player.position) < DANGER_DISTANCE: 
		state = [States.TELEPORT, States.MANUP].pick_random()
		
	#Ataque de laser
	if (position.distance_to(player.position) > DANGER_DISTANCE and position.distance_to(player.position) < SAFE_DISTANCE) and hit_box.disabled:
		act_state = Action_States.SMART_BEAN
	elif !hit_box.disabled:
		act_state = Action_States.NONE

	if position.distance_to(player.position) > 10:
		move_and_slide()
	

#	Controlar o sentido do Boss
	if position.x > player.position.x:
		direction = 1
	elif position.x < player.position.x:
		direction = -1
		
	if direction != old_direction:
		old_direction = direction
		scale.x = direction
		
	match state:
		States.IDLE: idle()
		States.WALK: walk()
		States.FLEE:  if state_last != States.FLEE:flee()
		States.TELEPORT: if state_last != States.TELEPORT:teleport()
		States.MANUP: if state_last != States.MANUP:manup()

	match act_state:
		Action_States.NONE: none()
		Action_States.SMART_BEAN: if act_state_last != Action_States.SMART_BEAN: smart_bean() # Com esse if, consigo controlar qual estado entra, e não repete ações
	
func idle():
	velocity = Vector2.ZERO
	
func walk():
	velocity = position.direction_to(player.position) * SPEED
	velocity.y = 0
	
func flee():
	velocity = -position.direction_to(player.position) * FLEE_SPEED

func teleport() -> void:
	if direction > 0:
		position.x = player.position.x - SAFE_DISTANCE
	elif direction < 0:
		position.x = player.position.x + SAFE_DISTANCE
	state_last = States.TELEPORT

func manup():
	velocity = position.direction_to(player.position) * FLEE_SPEED
	if position.distance_to(player.position) < DANGER_DISTANCE:
		state_last = States.MANUP


func none():
	hit_box.set_deferred("disabled", true)
	

func smart_bean():
	hit_box.set_deferred("disabled", false)
	act_state_last = Action_States.SMART_BEAN
