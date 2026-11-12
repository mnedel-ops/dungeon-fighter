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
	var idle = player.States.IDLE
	#runner.simulate_key_pressed(KEY_D)
		#await runner.await_input_processed()
		
	await_millis(3000)
	assert_that(state).is_equal(idle)
