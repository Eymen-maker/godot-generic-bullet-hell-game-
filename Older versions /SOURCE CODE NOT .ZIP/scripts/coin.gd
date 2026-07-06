extends CharacterBody2D
@onready var area_2d: Area2D = $Area2D

var speed :float
var velocity_dir
signal player_picked_up_money

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") : 
		player_picked_up_money.emit()
		queue_free()

func _ready() -> void:
	randomize()
	velocity_dir = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	speed = randi_range(1000,5000)

func _process(delta: float) -> void:
	speed = lerp(speed, 0.0 , 0.02)
	velocity = delta * velocity_dir * speed
	
	
	
	move_and_slide()
