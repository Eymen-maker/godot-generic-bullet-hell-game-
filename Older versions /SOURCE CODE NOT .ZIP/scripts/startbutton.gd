extends TextureButton

var PLACE = load("uid://d4beggoh7cs8k")
@onready var menu: Node2D = $"../.."
@onready var game: Node2D = $"../../.."



func _on_pressed() -> void:
	var start_game = PLACE.instantiate()
	game.add_child(start_game)
	menu.queue_free()
