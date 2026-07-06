extends Node2D


const PLACE = preload("uid://d4beggoh7cs8k")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass


func _restart_place_down_place():
	var new_place = PLACE.instantiate()
	add_child(new_place)
