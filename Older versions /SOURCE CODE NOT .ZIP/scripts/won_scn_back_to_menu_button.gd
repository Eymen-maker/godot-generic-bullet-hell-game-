extends Button

@onready var place: Node2D = $"/root/GAME/place"
@onready var game: Node2D = $"/root/GAME"
@onready var music_tracker: Node2D = $"/root/musicTracker"

var MENU = load("uid://c68aox83yacxf")

signal menu_music_start


func _on_pressed() -> void:
	menu_music_start.connect(music_tracker._menu_music_start, CONNECT_ONE_SHOT)
	menu_music_start.emit()
	var menu = MENU.instantiate()
	game.add_child(menu)
	Global.global_game_var_reset()
	place.queue_free()
	$"/root/GAME/you_won".queue_free()
