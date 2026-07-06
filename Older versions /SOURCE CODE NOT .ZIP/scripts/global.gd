extends Node2D

var score = 0
var you_lost = 0
var player_bullet_touching = 0
var player_bullet_collider_name 
var wave_count = 0 
var up_down 
var left_right
var player_direction

# wave creation
var wave_based_game_start # look
var tutorial = false
var custom_game_start = 0
var wave_power = 0
var wave = 0

# default values for custom levels
var runner_enemy_count_custom = 1
var runner_enemy_speed_custom = 100

var gunner_enemy_count_custom = 2
var bullet_speed_custom = 100

var player_health_custom = 100
var player_speed_custom = 100
var pistol_shootwait_time_custom = 0.1
var shotgun_shootwait_time_custom = 1

var sniper_enemy_count_custom = 0
var sniper_charge_up_time_custom = 5 # in seconds 
var sniper_cooldown_time_custom = 4


func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func number_approver(wanted_number, max_char_limit):
	if wanted_number == "0": 
		return 0
	if int(wanted_number) == int() :
		return "Enter a number"
	wanted_number = int(wanted_number)
	if wanted_number > max_char_limit:
		return "Too much"
	else:
		return wanted_number

func wave_designer ():
	if wave_based_game_start == true:
		wave_power = wave_count * 2
		sniper_enemy_count_custom = 100
