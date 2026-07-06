extends Label

@onready var timer: Timer = $Timer
@onready var you_won: Node2D = $"../../.."



func _process(_delta: float) -> void:
	var time_left = "%.1f" % timer.time_left
	
	if timer.time_left == 0.0:
		text = "you can continue"
		you_won.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		text = "you can continue in " + str(time_left) + " seconds"
		you_won.process_mode = Node.PROCESS_MODE_DISABLED
