extends Label



func _ready() -> void:
	text = "coin " + str(Global.coin_amount)
