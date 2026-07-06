extends TextureButton

@onready var place: Node2D = $"../../../place"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		Global.menu_status = 0
		place.process_mode = Node.PROCESS_MODE_INHERIT
		get_parent().get_parent().queue_free()


func _on_pressed() -> void:
	Global.menu_status = 0
	place.process_mode = Node.PROCESS_MODE_INHERIT
	get_parent().get_parent().queue_free()
