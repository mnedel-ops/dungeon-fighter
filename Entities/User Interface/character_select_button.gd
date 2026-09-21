extends Button

@export var Icon : Texture2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.icon= Icon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
