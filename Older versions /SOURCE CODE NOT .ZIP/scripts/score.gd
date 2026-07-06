extends Label

@onready var camera: Camera2D = $"../CHARACTER/Camera2D"

var offset = Vector2(-50, -50)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "healt = " + str(Global.player_healt)
	
	
	position = camera.global_position + offset
	
	
	
