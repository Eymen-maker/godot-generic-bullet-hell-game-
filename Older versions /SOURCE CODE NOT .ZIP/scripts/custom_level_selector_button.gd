extends TextureButton

@onready var menu: Node2D = $"../.."
@onready var game: Node2D = $"../../.."

const CUSTOM_LEVEL_SELECT_MENU = preload("uid://csm66hifc7kjk")


func _on_pressed() -> void:
	var custom_level_select = CUSTOM_LEVEL_SELECT_MENU.instantiate()
	game.add_child(custom_level_select)
	menu.queue_free()
	
	
	
	
