extends CharacterBody2D


const SPEED = 30000.0
var DASH = SPEED / 2


func _physics_process(delta: float) -> void:

	var up_down := Input.get_axis("forward","backward")
	var left_right := Input.get_axis("left","right")
	


	var direction = Vector2(left_right, up_down).normalized()

	velocity = direction * SPEED * delta
	
	if Input.is_action_just_pressed("dash"):
		global_position +=  Vector2(left_right * DASH * delta ,up_down * DASH * delta)

	


	move_and_slide()
