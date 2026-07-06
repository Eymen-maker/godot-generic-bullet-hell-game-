extends LineEdit



var max_char_limit = 1000

func _on_text_submitted(new_text: String) -> void:
	var output = Global.number_approver(new_text, max_char_limit)
	if output is String :
		placeholder_text = output
		text = ""
	elif output is int :
		text = str(output)
		Global.sniper_charge_up_time_custom = output
		Global.sniper_cooldown_time_custom = output
