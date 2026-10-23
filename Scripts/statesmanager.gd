extends Node
# Em estados que precisa de Input, eu nao preciso ativar nada de _process, controlo tudo por 
#aqui. 
var current_state : Node

func _ready() -> void:
	for state in get_children():
		state.set_process(false)
		state.set_physics_process(false)
	current_state.change_state($Idle)
	
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
		
func change_state(_go_state: Node):
	if _go_state == current_state:
		return
	else: current_state.set_process(false)
	current_state = _go_state
	current_state.enter()
