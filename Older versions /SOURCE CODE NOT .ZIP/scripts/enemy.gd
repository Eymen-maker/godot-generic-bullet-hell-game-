extends CharacterBody2D
const BLOOD = preload("uid://tu05slnhq737")


@onready var place: Node2D = $".."
@onready var character: CharacterBody2D = $"../character"
@onready var area_2d: Area2D = $Area2D
@onready var hurt_timer: Timer = $hurtTimer

var direction 
var speed = 80 #normaly its 80 * Global.runner_enemy_speed_custom = 8000
var touching_player = 1
var can_hurt = true
var damage = 5
var hurt_time = 0.05
@onready var local_char_health = 100

func _on_hurt_timer_timeout() -> void:
	can_hurt = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): 
		touching_player = 0
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"): 
		touching_player = 1


func _ready() -> void:
	speed *= Global.runner_enemy_speed_custom


func _process(delta: float) -> void:

	# for dir
	direction = character.global_position - global_position
	direction = direction.normalized()

	# for moving char
	velocity = direction * speed * delta * touching_player


	# hurting the player
	if touching_player == 0 :
		if can_hurt == true:
			Global.player_health_custom -= damage
			can_hurt = false
			hurt_timer.start(hurt_time)
	
	var local_char_name = get_name()
	if local_char_name == Global.player_bullet_collider_name:
		if Global.player_bullet_touching:
			local_char_health -= 5
			Global.player_bullet_touching = 0
			var blood = BLOOD.instantiate()
			place.add_child(blood)
			blood.global_position = global_position
	
	
	if local_char_health <= 0 :
		queue_free()
	
	
	move_and_slide()
