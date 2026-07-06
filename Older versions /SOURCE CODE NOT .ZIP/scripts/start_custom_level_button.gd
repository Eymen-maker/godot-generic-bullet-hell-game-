extends TextureButton
@onready var game: Node2D = $"../.."

const PLACE = preload("uid://d4beggoh7cs8k")




func _on_pressed() -> void:
	Global.custom_game_start = 1
	var place = PLACE.instantiate()
	game.add_child(place)
	get_parent().queue_free()
