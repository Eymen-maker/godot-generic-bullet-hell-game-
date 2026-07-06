extends CharacterBody2D
@onready var despawn_timer: Timer = $despawnTimer



var SPEED = 300
var despawntime = 3

func _ready() -> void:
	despawn_timer.start(despawntime)


func _physics_process(delta: float) -> void:
	# makes bullet go out of the gun forward
	position += transform.x * SPEED * delta 
	
	move_and_slide()


func _on_despawn_timer_timeout() -> void:
	queue_free()
