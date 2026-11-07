extends Node
# Em estados que precisa de Input, eu nao preciso ativar nada de _process, controlo tudo por 
#aqui. 
@export var current_state: Node
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var p_2: Player = $".."

func _ready() -> void:
	if current_state == null:
		current_state = $Idle
	current_state.enter()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		change_state($Attack)

	if Input.is_action_pressed("move-left") or Input.is_action_pressed("move-right"):
		change_state($Walk)
		return
	elif  Input.is_action_just_released("move-left") or Input.is_action_just_released("move-right"):
		change_state($Idle)
		return

	if Input.is_action_just_pressed("move-jump"):
		change_state($Jump)
		return
	if p_2.velocity.y >= 0 and not p_2.is_on_floor():
		animated_sprite_2d.play("Fall")
	elif p_2.is_on_floor():
		print("Cai")
		exit()

func change_state(_go_state: Node):
	if _go_state == null:
		return
	if current_state == _go_state:
		return
	current_state = _go_state
	current_state.enter()

func exit():
	change_state($Idle)
