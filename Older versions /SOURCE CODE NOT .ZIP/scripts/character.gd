extends CharacterBody2D


var SPEED = 200.0 # 200.0 * global.player_speed_custom = 20000.0
var DASH

func _ready() -> void:
	SPEED *= Global.player_speed_custom
	DASH = SPEED / 2



func _physics_process(delta: float) -> void:
	Global.up_down = Input.get_axis("forward","backward")
	Global.left_right = Input.get_axis("left","right")



	Global.player_direction = Vector2(Global.left_right, Global.up_down)
	var player_dir = Global.player_direction.normalized()

	velocity = player_dir * SPEED * delta
	
	if Input.is_action_just_pressed("dash"):
		global_position = global_position + Vector2(Global.left_right * DASH * delta ,Global.up_down * DASH * delta)
	move_and_slide()
	
	
	
	
