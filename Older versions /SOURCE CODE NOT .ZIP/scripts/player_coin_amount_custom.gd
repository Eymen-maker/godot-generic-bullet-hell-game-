extends LineEdit



var max_player_money = 99999999999999


func _on_text_submitted(new_text: String) -> void:
	var output = Global.number_approver(new_text, max_player_money)
	if output is String :
		placeholder_text = output
		text = ""
	elif output is int :
		Global.coin_amount_is_custom_made = output
		text = str(output)
		Global.coin_amount = output
