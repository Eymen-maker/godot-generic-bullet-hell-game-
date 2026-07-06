extends CharacterBody2D
@onready var despawn_timer: Timer = $despawnTimer


const SPEED = 300.0
var touching_enemys = 0
var despawn_time = 15

func _ready() -> void:
	despawn_timer.start(despawn_time)

func _on_despawn_timer_timeout() -> void:
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") :
		Global.player_bullet_touching = 1
		Global.player_bullet_collider_name = body.get_name()
		queue_free()
	
	
	

func _physics_process(delta: float) -> void:
	position += transform.x * SPEED * delta 

	move_and_slide()
