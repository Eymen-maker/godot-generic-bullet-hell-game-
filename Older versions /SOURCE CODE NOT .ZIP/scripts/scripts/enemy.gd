extends CharacterBody2D

@onready var character: CharacterBody2D = $"../CHARACTER"
@onready var area_2d: Area2D = $Area2D

var direction 
var speed = 8000
var touching_body = 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	touching_body = 0


func _on_area_2d_body_exited(body: Node2D) -> void:
	touching_body = 1


func _process(delta: float) -> void:
	direction = character.global_position - global_position
	direction = direction.normalized()

	velocity = direction * speed * delta * touching_body
	



	
	
	
	move_and_slide()
