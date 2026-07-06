extends TextureButton
@onready var game: Node2D = $"../.."
@onready var music_tracker: Node2D = $"/root/musicTracker"

const PLACE = preload("uid://d4beggoh7cs8k")

#Global.default_waves = false

signal fight_music_start

func _on_pressed() -> void:
	if Global.default_waves == false:
		Global.custom_game_start = 1
		fight_music_start.connect(music_tracker._fight_music_start, CONNECT_ONE_SHOT)
		fight_music_start.emit()
		var place = PLACE.instantiate()
		game.add_child(place)
		get_parent().queue_free()
	
	elif Global.default_waves == true:
		fight_music_start.connect(music_tracker._fight_music_start, CONNECT_ONE_SHOT)
		fight_music_start.emit()
		var place = PLACE.instantiate()
		game.add_child(place)
		get_parent().queue_free()


func _on_default_waves_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Global.default_waves = true
	if toggled_on == false:
		Global.default_waves = false
