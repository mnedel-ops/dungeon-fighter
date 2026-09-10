extends Control

@export var audio : Button
@export var audio_scene: PackedScene

@export var video : Button
@export var video_scene: PackedScene

@export var controls : Button
@export var controls_scene: PackedScene

@export var accessibility : Button
@export var accessibility_scene : PackedScene

@export var back : Button
@export var menu: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio.pressed.connect(_on_pressed_audio)
	video.pressed.connect(_on_pressed_video)
	controls.pressed.connect(_on_pressed_controls)
	accessibility.pressed.connect(_on_pressed_accessibility)
	back.pressed.connect(_on_pressed_back)

func _on_pressed_audio() -> void:
	get_tree().change_scene_to_packed(audio_scene)

func _on_pressed_video() -> void:
	get_tree().change_scene_to_packed(video_scene)

func _on_pressed_controls() -> void:
	get_tree().change_scene_to_packed(controls_scene)
	
func _on_pressed_accessibility() -> void:
	get_tree().change_scene_to_packed(accessibility_scene)

func _on_pressed_back() -> void:
	get_tree().change_scene_to_packed(menu)
	
	
