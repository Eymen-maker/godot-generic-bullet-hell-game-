extends LineEdit



var max_bullet_speed = 200

func _on_text_submitted(new_text: String) -> void:
	var output = Global.number_approver(new_text, max_bullet_speed)
	if output is String :
		placeholder_text = output
		text = ""
	elif output is int :
		text = str(output)
		Global.bullet_speed_custom = output
