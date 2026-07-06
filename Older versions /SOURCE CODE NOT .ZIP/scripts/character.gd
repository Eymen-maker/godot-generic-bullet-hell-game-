extends CharacterBody2D
@onready var coin_area: Area2D = $"../coin/Area2D"
@onready var dash_timer: Timer = $dashTimer
@onready var coin: Area2D = $"../coin"
@onready var place: Node2D = $".."
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var SPEED = 200.0 # 200.0 * global.player_speed_custom = 20000.0
var DASH
#Global.max_dash_storage
#Global.current_dash_storage

func _on_money_picked():
	Global.coin_amount += 1
	audio_stream_player.play()


func _on_dash_timer_timeout() -> void:
	Global.current_dash_storage += 1

func _ready() -> void:
	var speed2 = Global.player_speed_custom * SPEED 
	DASH = speed2 / 2


func _physics_process(delta: float) -> void:
	
	var speed = Global.player_speed_custom * SPEED

	
	Global.up_down = Input.get_axis("forward","backward")
	Global.left_right = Input.get_axis("left","right")

	Global.player_direction = Vector2(Global.left_right, Global.up_down)
	var player_dir = Global.player_direction.normalized()

	velocity = player_dir * speed * delta
	
	if Global.current_dash_storage > 0:
		if Input.is_action_just_pressed("dash"):
			Global.current_dash_storage -= 1
			global_position = global_position + Vector2(Global.left_right * DASH * delta ,Global.up_down * DASH * delta)
	
	
	
	if Global.current_dash_storage < Global.max_dash_storage:
		if dash_timer.is_stopped():
			dash_timer.start(Global.dash_regain_time)
	
	
	
	move_and_slide()
	
	
	
	
