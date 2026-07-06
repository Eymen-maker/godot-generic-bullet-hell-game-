extends CharacterBody2D

@onready var character: CharacterBody2D = $"../CHARACTER"
@onready var area_2d: Area2D = $Area2D
@onready var hurt_timer: Timer = $hurtTimer

var direction 
var speed = 8000
var touching_body = 1
var can_hurt = true
var damage = 5
var hurt_time = 0.05

func _on_hurt_timer_timeout() -> void:
	can_hurt = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CHARACTER": 
		touching_body = 0
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "CHARACTER": 
		touching_body = 1


func _process(delta: float) -> void:

	# for dir
	direction = character.global_position - global_position
	direction = direction.normalized()

	# for moving char
	velocity = direction * speed * delta * touching_body


	# hurting the player
	if touching_body == 0 :
		if can_hurt == true:
			Global.player_healt -= damage
			can_hurt = false
			hurt_timer.start(hurt_time)


	
	
	
	move_and_slide()
