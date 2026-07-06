extends TextureButton

var PLACE = load("uid://d4beggoh7cs8k")
@onready var menu: Node2D = $"../.."
@onready var game: Node2D = $"../../.."



func _on_pressed() -> void:
	Global.tutorial = true
	var start_game = PLACE.instantiate()
	game.add_child(start_game)
	Global.wave_based_game_start = true
	Global.runner_enemy_count_custom = 1
	Global.gunner_enemy_count_custom = 0
	Global.sniper_enemy_count_custom = 0
	menu.queue_free()
