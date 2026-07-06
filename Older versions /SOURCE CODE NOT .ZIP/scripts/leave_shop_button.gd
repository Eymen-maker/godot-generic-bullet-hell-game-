extends Button

@onready var place: Node2D = $"../../place"
@onready var music_tracker: Node2D = $"/root/musicTracker"

signal shop_deactivated


func _ready() -> void:
	shop_deactivated.connect(music_tracker._shop_deactivated, CONNECT_ONE_SHOT)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("shop"):
		Global.shop_status = 0
		shop_deactivated.emit()
		place.process_mode = Node.PROCESS_MODE_INHERIT
		get_parent().queue_free()



func _on_pressed() -> void:
	Global.shop_status = 0
	shop_deactivated.emit()
	place.process_mode = Node.PROCESS_MODE_INHERIT
	get_parent().queue_free()
