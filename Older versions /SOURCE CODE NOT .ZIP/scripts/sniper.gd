extends CharacterBody2D


@onready var chargeup_timer: Timer = $chargeupTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cooldown_timer: Timer = $cooldownTimer
@onready var character: CharacterBody2D = $"../character"
@onready var shootwait_timer: Timer = $shootwaitTimer
@onready var marker_2d: Marker2D = $Marker2D
@onready var place: Node2D = $".."

const BLOOD = preload("uid://tu05slnhq737")
const SNIPER_LINE = preload("uid://mfmkwoffgvae")

var cooldownTime = Global.sniper_cooldown_time_custom
@export var local_char_health = 50
var charge_up_start = 0
var shoot = 0
var warning_light = 0
#for "aim_guessing" look at sniper_line scene
var where_player_will_be

func _ready() -> void:
	cooldown_timer.start(cooldownTime)

func _on_cooldown_timer_timeout() -> void:
	charge_up_start = 1


func _on_chargeup_timer_timeout() -> void:
	cooldown_timer.start(cooldownTime)
	warning_light = 0




func _process(delta: float) -> void:
	if warning_light == 1:
		if character:
			look_at(where_player_will_be)
	else:
		if character:
			look_at(character.global_position)
		
		
		
	
	# makes rot_degree restart at 360 to 0 
	var rotation_degrees2 = wrapf(rotation_degrees,0.0,360.0)

	
	# it works / flips char when needed
	if rotation_degrees2 > 270:
		animated_sprite_2d.flip_v = false
	elif rotation_degrees2 > 90:
		animated_sprite_2d.flip_v = true
	elif rotation_degrees2 < 90:
		animated_sprite_2d.flip_v = false





	if charge_up_start == 1:
		var line = SNIPER_LINE.instantiate()
		add_child(line)
		line.global_position = $Marker2D.global_position
		line.global_rotation = $Marker2D.global_rotation
		chargeup_timer.start(Global.sniper_charge_up_time_custom)
		charge_up_start = 0

	var local_char_name = get_name()
	if local_char_name == Global.player_bullet_collider_name:
		if Global.player_bullet_touching:
			local_char_health -= 5
			Global.player_bullet_touching = 0
			var blood = BLOOD.instantiate()
			place.add_child(blood)
			blood.global_position = global_position
	
	
	if local_char_health <= 0:
		queue_free()
