extends LineEdit


var max_player_health = 900000000

func _on_text_submitted(new_text: String) -> void:
	var output = Global.number_approver(new_text, max_player_health)
	if output is String :
		placeholder_text = output
		text = ""
	elif output is int :
		text = str(output)
		Global.max_player_health_custom = output
