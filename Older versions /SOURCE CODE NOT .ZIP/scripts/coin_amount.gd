extends Label







func _process(_delta: float) -> void:
	text = "you have " + str(Global.coin_amount) + " coins"
