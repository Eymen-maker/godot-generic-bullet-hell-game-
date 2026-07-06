extends TextureButton

@onready var place: Node2D = $"../../../place"
@onready var game: Node2D = $"../../.."
@onready var music_tracker: Node2D = $"/root/musicTracker"

var MENU = load("uid://c68aox83yacxf")

signal menu_music_start

func _on_pressed() -> void:
	Global.menu_status = 0
	menu_music_start.connect(music_tracker._menu_music_start, CONNECT_ONE_SHOT)
	menu_music_start.emit()
	var menu = MENU.instantiate()
	game.add_child(menu)
	Global.global_game_var_reset()
	place.queue_free()
	get_parent().get_parent().queue_free()
	
