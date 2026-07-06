extends CharacterBody2D


const SPEED = 300.0
var touching_enemys = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") :
		Global.player_bullet_touching = 1
		Global.player_bullet_collider_name = body.get_name()
		queue_free()
	
	
	

func _physics_process(delta: float) -> void:
	position += transform.x * SPEED * delta 

	move_and_slide()


	
	
	
	
