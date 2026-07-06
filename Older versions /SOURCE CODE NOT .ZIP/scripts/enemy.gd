extends CharacterBody2D
const BLOOD = preload("uid://tu05slnhq737")
const COIN = preload("uid://dmf0fgxfh7iqg")


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

func _on_area_2d_area_entered(area: Area2D) -> void:
		if area.is_in_group("player_bullet"):
			get_damaged(area)

func _ready() -> void:
	var deviation = 1000
	randomize()
	speed = randi_range(speed * Global.runner_enemy_speed_custom + deviation, speed * Global.runner_enemy_speed_custom - deviation)
	print(speed)


func _process(delta: float) -> void:
	
	
	# for dir
	if character:
		direction = character.global_position - global_position
		direction = direction.normalized()

	# for moving char
	if character:
		velocity = direction * speed * delta * touching_player


	# hurting the player
	if touching_player == 0 :
		if can_hurt == true:
			Global.current_player_health -= damage
			can_hurt = false
			hurt_timer.start(hurt_time)
	
	# spawns coin
	if local_char_health <= 0:
		for i in range(1):
			var coin = COIN.instantiate()
			place.add_child(coin)
			coin.player_picked_up_money.connect(character._on_money_picked)
			coin.global_position = global_position
		queue_free()
	
	move_and_slide()
	


func get_damaged(area):
	if area.name == "player_bullet_area2d":
		local_char_health -= Global.player_pistol_bullet_damage
		Global.put_blood(place, BLOOD, global_position)
		#did_i_die(local_char_health)
	
	elif area.name == "player_shotgun_pellet_area2d":
		local_char_health -= Global.player_shotgun_pellet_damage
		Global.put_blood(place, BLOOD, global_position)
		#did_i_die(local_char_health)
