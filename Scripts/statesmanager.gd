extends Node
# Em estados que precisa de Input, eu nao preciso ativar nada de _process, controlo tudo por 
#aqui. 
var current_state : Node

func _ready() -> void:
	for state in get_children():
		state.set_process(false)
		state.set_physics_process(false)
	
	current_state = $Idle
	current_state.enter()

func _process(delta: float) -> void:
	#ataque
	if Input.is_action_just_pressed("attack"):
		change_state($Attack)
	elif Input.is_action_just_released("attack"):
		change_state($Idle)
		
	if Input.is_action_pressed("move-left") or Input.is_action_pressed("move-right"):
		change_state($Walk)
		
func change_state(_go_state: Node):
	current_state = _go_state
	current_state.enter()
