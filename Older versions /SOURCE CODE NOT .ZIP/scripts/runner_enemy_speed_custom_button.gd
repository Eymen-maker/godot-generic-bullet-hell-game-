extends LineEdit



var max_runner_speed = 1000

func _on_text_submitted(new_text: String) -> void:
	var output = Global.number_approver(new_text, max_runner_speed)
	if output is String :
		placeholder_text = output
		text = ""
	elif output is int :
		text = str(output)
		Global.runner_enemy_speed_custom = output
