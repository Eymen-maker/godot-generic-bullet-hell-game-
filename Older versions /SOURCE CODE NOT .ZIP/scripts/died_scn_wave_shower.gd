extends Label



func _ready() -> void:
	if Global.custom_game_start == 1 or Global.default_waves == true:
		text = "custom wave " + str(Global.wave)
	else:
		text = "wave " + str(Global.wave)
