extends Control

@export var versus : Button
@export var versus_scene : PackedScene

@export var settings : Button
@export var settings_scene : PackedScene 

@export var credits : Button
@export var credits_scene : PackedScene

@export var exit : Button

func _ready() -> void:
	versus.pressed.connect(_on_pressed_versus)
	settings.pressed.connect(_on_pressed_settings)
	credits.pressed.connect(_on_pressed_credits)
	exit.pressed.connect(_on_pressed_exit)
	

func _on_pressed_versus() -> void:
	get_tree().change_scene_to_packed(versus_scene)

func _on_pressed_settings() -> void:
	get_tree().change_scene_to_packed(settings_scene)

func _on_pressed_credits() -> void:
	get_tree().change_scene_to_packed(credits_scene)

func _on_pressed_exit() -> void:
	get_tree().quit()
