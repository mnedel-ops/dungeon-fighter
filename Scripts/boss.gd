extends CharacterBody2D
class_name Boss

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player: Player = get_tree().current_scene.get_node("Player") #pega o node da arvore

const JUMP_VELOCITY = -256
const SPEED = 16.0
const FLEE_SPEED = SPEED * 2

const SAFE_DISTANCE : float = 64.00
const DANGER_DISTANCE : float = SAFE_DISTANCE/2

enum States {IDLE, WALK, JUMP, FALL, FLEE, TELEPORT}
enum Action_States {NONE, ATTACK, INTELLECT_EAT, SMART_BEAN}

var act_state: Action_States = Action_States.NONE
var state: States = States.IDLE

@onready var hit_box: CollisionShape2D = $Node2D/HitBox/HitBox


var direction : int = 1
var old_direction :int = direction


#Sortear o estado de fuga e de ataque
#var states = [State.Idle, State.Walk, State.Attack]
#var next_state = states.pick_random()   
func _ready() -> void:
	hit_box.set_deferred("disabled", true)
func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	
	# Estados
	if position.distance_to(player.position) > SAFE_DISTANCE:
		state = States.WALK
	else: 
		state = States.IDLE
	
	if position.distance_to(player.position) < DANGER_DISTANCE:
		state = States.FLEE
		
	#Ataque de laser
	if (position.distance_to(player.position) > DANGER_DISTANCE and position.distance_to(player.position) < SAFE_DISTANCE) and hit_box.disabled:
		act_state = Action_States.SMART_BEAN
	elif !hit_box.disabled:
		act_state = Action_States.NONE
	if position.distance_to(player.position) > 10:
		move_and_slide()
	
	if state == States.FLEE and velocity.x == 0:
		state = States.TELEPORT

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
		#States.FLEE: flee()
		#States.TELEPORT: teleport()
	match act_state:
		Action_States.NONE: none()
		Action_States.SMART_BEAN: smart_bean()
	
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


func none():
	hit_box.set_deferred("disabled", true)
	

func smart_bean():
	hit_box.set_deferred("disabled", false)
