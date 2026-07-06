extends CharacterBody2D
@onready var despawn_timer: Timer = $despawnTimer

var SPEED = 600
var pellet_despawn_time = 2

func _ready() -> void:
	despawn_timer.start(pellet_despawn_time)


func _process(delta: float) -> void:
	position += transform.x * SPEED * delta 



func _on_player_shotgun_pellet_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		queue_free()


func _on_despawn_timer_timeout() -> void:
	queue_free()
