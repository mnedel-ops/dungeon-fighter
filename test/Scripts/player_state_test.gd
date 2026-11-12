# GdUnit generated TestSuite
class_name PlayerStateTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

var runner := scene_runner("res://match_scene.tscn")
var player :Player= runner.invoke("find_child", "P2")

# TestSuite generated from
const __source: String = 'res://Scripts/player.gd'

#apertar para a direita, e o estato deve ser walk.

func test_starting_state() -> void:
	await runner.simulate_frames(2)
	var state = player.state
	
	assert_that(state).is_equal(player.States.IDLE)

func test_walk_state() -> void:
	runner.simulate_key_press(KEY_D)
	await runner.simulate_frames(90) #ignora esse aviso. precisa ter o await
	
	var state = player.state
	
	assert_that(state).is_equal(player.States.WALK)
	
func test_jump_state() -> void:
	runner.simulate_key_pressed(KEY_W)
	await runner.simulate_frames(1)
	
	var state = player.state
	assert_that(state).is_equal(player.States.JUMP)
	
func test_attack_state() -> void:
	runner.simulate_key_pressed(KEY_J)
	await runner.simulate_frames(1)
	
	var state = player.state
	assert_that(state).is_equal(player.States.ATTACK)

func test_idle_walk() -> void: #Teste de Walk para Idle
	runner.simulate_key_press(KEY_D)
	await runner.simulate_frames(20) #primeiro simula o caminhar
	
	runner.simulate_key_release(KEY_D)
	await runner.simulate_frames(10) #depois simular o parar
	var state = player.state
	
	assert_that(state).is_equal(player.States.IDLE)
	
func test_idle_jump_state() -> void: #Jump para Idle
	runner.simulate_key_pressed(KEY_W)
	await runner.simulate_frames(50)
	
	var state = player.state
	assert_that(state).is_equal(player.States.IDLE)
	
