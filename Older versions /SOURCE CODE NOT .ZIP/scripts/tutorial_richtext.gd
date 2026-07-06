extends RichTextLabel




func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var tutorial_level = get_parent().tutorial_level  # could have made it a global var 
	
	if Global.tutorial == false:
		queue_free()
	elif tutorial_level == 1:
		visible = 1
		text = "sup look here \nkill the runner ( red guy ) by shooting it with left mouse button"
	elif tutorial_level == 2:
		text = "this is the gunner it periodically shoots and stops"
	elif tutorial_level == 3: # update this when new tutorial levels
		text = "this is the sniper. it  has the lowest hp and shoots very slowly but it can predict where you will be "
