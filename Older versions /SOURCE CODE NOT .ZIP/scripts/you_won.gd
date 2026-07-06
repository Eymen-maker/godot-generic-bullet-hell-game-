extends Node2D

@onready var camera: Camera2D = $"../place/character/Camera2D"

func _ready() -> void:
	position = camera.global_position
