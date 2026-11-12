# GdUnit generated TestSuite
class_name PlayerTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

var runner := scene_runner("res://match_scene.tscn")
var player :Player= runner.invoke("find_child", "P2")

# TestSuite generated from
const __source: String = 'res://Scripts/player.gd'

#apertar para a direita, e o estato deve ser walk.

func test_idle_state() -> void:
	var state = player.state
	
	assert_that(state).is_equal(player.States.IDLE)

func test_walk_state() -> void:
	runner.simulate_key_press(KEY_D)
	await runner.simulate_frames(90)
	
	var state = player.state
	
	assert_that(state).is_equal(player.States.WALK)
