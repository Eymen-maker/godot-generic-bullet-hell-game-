extends CharacterBody2D
@onready var coin_area: Area2D = $"../coin/Area2D"
@onready var dash_timer: Timer = $dashTimer
@onready var coin: Area2D = $"../coin"
@onready var place: Node2D = $".."
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var character: CharacterBody2D = $"."
@onready var parry_timer: Timer = $ParryTimer
@onready var parry_area: Area2D = $ParryArea
@onready var parry_particles: GPUParticles2D = $ParryParticles
@onready var unsuccessful_parry_particles: GPUParticles2D = $UnsuccessfulParryParticles
@onready var parry_debuff_timer: Timer = $ParryDebuffTimer

const ITEM_BOMB = preload("uid://d4gk3f7rnx5ak")

var SPEED = 200.0 # 200.0 * global.player_speed_custom = 20000.0
var DASH
var once = 0
var example_area
var parry_unsuccessful = 1 # 1 means false , 2 means true  
var parry_debuff_time = 6
#Global.max_dash_storage
#Global.current_dash_storage

func _on_money_picked():
	Global.coin_amount += 1
	audio_stream_player.play()

func _on_dash_timer_timeout() -> void:
	Global.current_dash_storage += 1

func _on_parry_debuff_timer_timeout() -> void:
	if parry_unsuccessful > 1:
		parry_unsuccessful -= 1

func _ready() -> void:
	var speed2 = Global.player_speed_custom * SPEED 
	DASH = speed2 / 2
	


func _physics_process(delta: float) -> void:
	
	var speed = Global.player_speed_custom * SPEED
	
	Global.up_down = Input.get_axis("forward","backward")
	Global.left_right = Input.get_axis("left","right")
	
	Global.player_direction = Vector2(Global.left_right, Global.up_down)
	var player_dir = Global.player_direction.normalized()
	
	velocity = (player_dir * speed * delta) / parry_unsuccessful
	
	# for dash use
	if Global.current_dash_storage > 0:
		if Input.is_action_just_pressed("dash"):
			Global.current_dash_storage -= 1
			global_position = global_position + Vector2(Global.left_right * DASH * delta ,Global.up_down * DASH * delta)
	
	# for dash recharge
	if Global.current_dash_storage < Global.max_dash_storage:
		if dash_timer.is_stopped():
			dash_timer.start(Global.dash_regain_time)
	
	if Input.is_action_just_pressed("throw bomb"):
		if Global.current_player_bomb_amount > 0:
			var bomb = ITEM_BOMB.instantiate()
			bomb.where_it_was = global_position
			#bomb.where_it_should_go = get_local_mouse_position() 
			place.add_child(bomb)
			bomb.global_position = character.global_position
			Global.current_player_bomb_amount -= 1

	if parry_timer.is_stopped():
		if Input.is_action_just_pressed("parry"):
			unsuccessful_parry_particles.emitting = false
			parry_particles.emitting = false
			parry_area.process_mode = Node.PROCESS_MODE_INHERIT
			parry_timer.start(2)

	if parry_area.process_mode == Node.PROCESS_MODE_INHERIT:
		once += 1
		if once == 2:
			if EnemyBulletInParryArea_count() <= 0: #group EnemyBulletInParryArea will output in 2x because both the area and the parent is in group 
				parry_unsuccessful += 1             # but not the EnemyBulletInParryArea_count() func
				if parry_unsuccessful == 2:
					parry_debuff_timer.start(parry_debuff_time)
				unsuccessful_parry_particles.emitting = true
			if EnemyBulletInParryArea_count() >= 1:
				print(EnemyBulletInParryArea_count())
				parry_particles.emitting = true
				Global.current_player_health += clamp(((EnemyBulletInParryArea_count() - 1) * 5),0,15)
				
			parry_area.process_mode = Node.PROCESS_MODE_DISABLED
			once = 0
	
	move_and_slide()
	
	



func EnemyBulletInParryArea_count():
	@warning_ignore("integer_division")
	return get_tree().get_nodes_in_group("EnemyBulletInParryArea").size() / 2
