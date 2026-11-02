extends Node
# Em estados que precisa de Input, eu nao preciso ativar nada de _process, controlo tudo por 
#aqui. 
@export var current_state : Node = null
@onready var state: Node = current_state
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

func _input(event: InputEvent) -> void:
	#ataque
	if Input.is_action_pressed("attack"):
		change_state($Attack)

		
	if Input.is_action_pressed("move-left") or Input.is_action_pressed("move-right"):
		change_state($Walk)
	if Input.is_action_just_released("move-left") or Input.is_action_just_released("move-right"):
		change_state($Idle)
		
	if Input.is_action_just_pressed("move-jump"):
		change_state($Jump)
		

func change_state(_go_state: Node):
	if _go_state == current_state:
		return
	elif _go_state != current_state: current_state.set_process(true)
	current_state = _go_state
	current_state.enter()
