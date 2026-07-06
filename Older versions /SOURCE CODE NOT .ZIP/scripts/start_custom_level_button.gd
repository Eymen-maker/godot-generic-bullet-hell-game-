extends TextureButton
@onready var game: Node2D = $"../.."

const PLACE = preload("uid://d4beggoh7cs8k")




func _on_pressed() -> void:
	var place = PLACE.instantiate()
	game.add_child(place)
	get_parent().queue_free()
