extends CanvasLayer

@onready var camera: Camera2D = $"../place/character/Camera2D"

func _ready() -> void:
	pass
	#global_position = camera.global_position + Vector2(0,5)
