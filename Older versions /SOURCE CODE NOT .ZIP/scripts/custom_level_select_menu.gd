extends Node2D
@onready var game: Node2D = $".."

var MENU = load("uid://c68aox83yacxf")



func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		#default values
		Global.global_game_var_reset()
		var menu = MENU.instantiate()
		game.add_child(menu)
		queue_free()
		
