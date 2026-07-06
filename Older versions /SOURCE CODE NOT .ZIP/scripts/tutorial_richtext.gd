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
	elif tutorial_level == 3: 
		text = "this is the sniper. it  has the lowest hp and shoots very slowly but it can predict where you will be "
	elif tutorial_level == 4:
		text = "you can press 2 for your shotgun. try it \n\nit has high damage but also has high spread"
	elif tutorial_level == 5:
		text = "You can open the shop by pressing g and the small yellow circle on the ground is the money"
	elif tutorial_level == 6:
		text = "Now buy a bomb, you can throw it with e. It won't hurt you."
	elif tutorial_level == 7:
		text = "you can parry with f or right mouse button. \n\nif you miss you will slow down \n\nand if you successfully parry one bullet notting bad will happen \n\nbut when you parry more than one bullet you are going to get +5 hp for every bullet more then one"
	elif tutorial_level == 8:
		text = "you can also dash with space which teleports you so that you can escape from dangers.\n\nthis dashs default recharge time is 6 seconds but you can upgrage it to have faster recharge or store dashes \n\nyou win after the thirtieth wave \ngood luck"
		# update this when new tutorial levels
		
		
		
	
