extends Node2D

@onready var character: CharacterBody2D = $"../place/character"

func _ready() -> void:
	global_position = character.global_position 
