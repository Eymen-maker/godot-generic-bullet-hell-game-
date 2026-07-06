extends CharacterBody2D
@onready var despawn_timer: Timer = $despawnTimer
@onready var area_2d: Area2D = $Area2D



var SPEED = 300
var despawntime = 3
var touching_body = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CHARACTER": 
		touching_body = true

# un-needed rn # look up vro
#func _on_area_2d_body_exited(body: Node2D) -> void:
#	if body.name == "CHARACTER": 
#		touching_body = false




func _ready() -> void:
	despawn_timer.start(despawntime)


func _physics_process(delta: float) -> void:
	# makes bullet go out of the gun forward
	position += transform.x * SPEED * delta 
	
	move_and_slide()

	if touching_body == true:
		Global.player_healt -= 10
		queue_free()






func _on_despawn_timer_timeout() -> void:
	queue_free()
