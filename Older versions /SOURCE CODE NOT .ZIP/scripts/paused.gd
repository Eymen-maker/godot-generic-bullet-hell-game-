extends Node2D

@onready var character: CharacterBody2D = $"../place/character"


func _ready() -> void:
	global_position = character.global_position 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
