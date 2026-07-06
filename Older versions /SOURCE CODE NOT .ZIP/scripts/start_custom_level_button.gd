extends TextureButton
@onready var game: Node2D = $"../.."
@onready var music_tracker: Node2D = $"/root/musicTracker"

const PLACE = preload("uid://d4beggoh7cs8k")


signal fight_music_start

func _on_pressed() -> void:
	Global.custom_game_start = 1
	fight_music_start.connect(music_tracker._fight_music_start, CONNECT_ONE_SHOT)
	fight_music_start.emit()
	var place = PLACE.instantiate()
	game.add_child(place)
	get_parent().queue_free()
