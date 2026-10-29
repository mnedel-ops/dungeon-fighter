extends Node
# Em estados que precisa de Input, eu nao preciso ativar nada de _process, controlo tudo por 
#aqui. 
@export var current_state : State = null

@onready var state: State = (func get_initial_state() -> State: 
	return initial_state if initial_state != null else get_child(0).call())

func _ready() -> void:
	for state in get_children():
		state.set_process(false)
		state.set_physics_process(false)
	change_state($Idle)
	
func _input(event: InputEvent) -> void:
	#ataque
	if Input.is_action_just_pressed("attack"):
		change_state($Attack)
	elif Input.is_action_just_released("attack"):
		change_state($Idle)
		
	if Input.is_action_pressed("move-left") or Input.is_action_pressed("move-right"):
		change_state($Walk)
	if Input.is_action_just_released("move-left") or Input.is_action_just_released("move-right"):
		change_state($Idle)
		
	if Input.is_action_just_pressed("move-jump"):
		change_state($Jump)
		

func change_state(_go_state: Node):
	if _go_state == current_state:
		return
	elif _go_state != current_state and current_state.can_process(): current_state.set_process(true)
	current_state = _go_state
	current_state.enter()
