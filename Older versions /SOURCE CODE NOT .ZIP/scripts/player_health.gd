extends Label

@onready var camera: Camera2D = $"../character/Camera2D"

var offset = Vector2(-50, -50)


func _process(delta: float) -> void:
	text = "health = " + str(Global.current_player_health)
	
	if camera:
		position = camera.global_position + offset
	
	
	
