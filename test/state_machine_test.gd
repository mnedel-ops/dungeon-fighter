extends GdUnitTestSuite

const PlayerScene = preload("res://ENTITIES/Characters/player.tscn")
var runner : GdUnitSceneRunner
var player : Player

func before_test() -> void:
	runner = scene_runner(PlayerScene)
	player = runner.scene() as Player
	
func test_idle():
	await runner.simulate_frames(0, 0.016)
	assert_that(player.state).is_equal(Player.States.IDLE)
	assert_that(player.velocity.x).is_equal(0.0)
