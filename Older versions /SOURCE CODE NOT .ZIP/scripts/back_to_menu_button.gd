extends TextureButton

@onready var place: Node2D = $"../../../place"
@onready var game: Node2D = $"../../.."

var MENU = load("uid://c68aox83yacxf")


func _on_pressed() -> void:
	Global.menu_status = 0
	var menu = MENU.instantiate()
	game.add_child(menu)
	Global.global_game_var_reset()
	place.queue_free()
	get_parent().get_parent().queue_free()
	
