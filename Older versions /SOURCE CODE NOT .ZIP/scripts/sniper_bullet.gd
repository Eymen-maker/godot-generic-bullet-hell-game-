extends CharacterBody2D

var touching_body = false
var SPEED = 3000
@export var damage = 100


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") : 
		touching_body = true
		#print("hit")


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	
	# makes bullet go out of the gun forward
	position += transform.x * SPEED * delta 
	
	move_and_slide()

	if touching_body == true:
		Global.current_player_health -= damage
		queue_free()
