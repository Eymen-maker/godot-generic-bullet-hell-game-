extends TextureButton

var PLACE = load("uid://d4beggoh7cs8k")
@onready var menu: Node2D = $"../.."
@onready var game: Node2D = $"../../.."
@onready var music_tracker: Node2D = $"/root/musicTracker"


signal fight_music_start

func _on_pressed() -> void:
	print(music_tracker)
	Global.wave_based_game_start = true
	Global.runner_enemy_count_custom = 1
	Global.gunner_enemy_count_custom = 2
	Global.sniper_enemy_count_custom = 1
	fight_music_start.connect(music_tracker._fight_music_start, CONNECT_ONE_SHOT)
	fight_music_start.emit()
	
	var start_game = PLACE.instantiate()
	game.add_child(start_game)
	menu.queue_free()
