extends Node2D
@onready var game: Node2D = $".."

var MENU = load("uid://c68aox83yacxf")



func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		#default values
		Global.runner_enemy_count_custom = 1
		Global.runner_enemy_speed_custom = 100
		Global.gunner_enemy_count_custom = 2
		Global.bullet_speed_custom = 100
		Global.player_health_custom = 100
		Global.player_speed_custom = 100
		Global.sniper_charge_up_time_custom = 5 # in seconds
		Global.sniper_cooldown_time_custom = 4
		Global.sniper_enemy_count_custom = 0
		
		
		
		
		
		var menu = MENU.instantiate()
		game.add_child(menu)
		queue_free()
		
