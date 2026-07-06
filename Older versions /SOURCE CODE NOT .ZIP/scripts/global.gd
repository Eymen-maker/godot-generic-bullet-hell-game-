extends Node2D

var score = 0
var you_lost = 0
var player_bullet_touching = 0
var player_bullet_collider_name 
# default values for custom levels
var runner_enemy_count_custom = 1
var runner_enemy_speed_custom = 100
var gunner_enemy_count_custom = 2
var bullet_speed_custom = 100
var player_health_custom = 100
var player_speed_custom = 100

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if score <= 0 :
		you_lost = 1
	

func number_approver(wanted_number, max_char_limit):
	if int(wanted_number) == int() :
		return "Enter a number"
	wanted_number = int(wanted_number)
	if wanted_number > max_char_limit:
		return "Too much"
	else:
		return wanted_number
	
	
	
	
	
