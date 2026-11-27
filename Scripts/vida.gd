extends Node
const VIDA_Max : int = 3
var vida_atual : int = VIDA_Max
signal morri
func _on_pain_box_area_entered(area: Area2D) -> void:
	vida_atual -=1
	print("Uf")
	if vida_atual <= 0:
		morri.emit()
	
