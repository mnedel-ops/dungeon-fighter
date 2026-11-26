extends Node
const VIDA_Max : int = 9
var vida_atual : int = VIDA_Max

func _on_pain_box_area_entered(area: Area2D) -> void:
	vida_atual -=1
