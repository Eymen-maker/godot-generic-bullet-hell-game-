extends Node2D

@onready var update_tracker: Node2D = $"/root/updatetracker"
signal global_game_upg_reset


var score = 0
var you_lost = 0
var up_down 
var left_right
var player_direction

# NOTE CHANGE ALL ADD ALL THE CHANGED VARS TO THE VAR RESET FUNC BELOW ==============================================
# wave creation
var wave_based_game_start # look
var tutorial = false
var custom_game_start = 0
var wave_power = 0
var wave = 0
var custom_no_enemies_game = 0

# menu 
var menu_status = 0
# shop
var shop_status = 0

# default values for custom levels
var default_waves = false

var runner_enemy_count_custom = 0
var runner_enemy_speed_custom = 100

var gunner_enemy_count_custom = 0
var bullet_speed_custom = 100
var bullet_damage_custom = 5

#var player_info = {
#"max_health" : max_player_health_custom,
#"current_health" : current_player_health,
#"speed" : player_speed_custom,
#"pistol" : player_bullet_damage}

var max_player_health_custom = 100
var current_player_health = 100
var player_speed_custom = 100
var coin_amount = 0
var coin_amount_is_custom_made = 0
var max_player_health_is_custom_made = 100
var max_dash_storage = 1
var current_dash_storage = 1
var dash_regain_time = 6

var pistol_shootwait_time_custom = 0.1
var player_pistol_bullet_damage = 5

var shotgun_shootwait_time_custom = 1
var shotgun_pellet_amount_custom = 4
var player_shotgun_pellet_damage = 5

var sniper_enemy_count_custom = 0
var sniper_charge_up_time_custom = 5 # in seconds 
var sniper_cooldown_time_custom = 4
var sniper_bullet_damage = 50

#  ITEMS
var item_bomb_damage 
var current_player_bomb_amount = 0


#NOTE: CHANGE ALL ADD ALL THE CHANGED VARS TO THE VAR RESET FUNC BELOW ==============================================
#NOTE 2: also in you_lost scn, retry script there is more stuff for custom levels 

# FUNC AREA ==================================================== FUNC AREA #
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

func put_blood(where, BLOOD, global_position2):
	var blood = BLOOD.instantiate()
	where.add_child(blood)
	blood.global_position = global_position2

func buying_something(level, coin_cost, max1, changing_value, value): 
	var array = [0, changing_value, level]
	if level < max1:
		if coin_amount >= coin_cost:
			coin_amount-= coin_cost
			changing_value += value
			array[1] = changing_value
			array[2] =  1 + level
			array[0] = 1
			return array
		else:
			return  array
	else:
		return array

func global_game_var_reset():
	
	score = 0
	you_lost = 0
	up_down 
	left_right
	player_direction

# wave creation
	wave_based_game_start # look
	tutorial = false
	custom_game_start = 0
	wave_power = 0
	wave = 0
	custom_no_enemies_game = 0

	# menu 
	menu_status = 0
	# shop
	shop_status = 0
	global_game_upg_reset.connect(update_tracker._global_game_upg_reset, CONNECT_ONE_SHOT)
	global_game_upg_reset.emit()

	# default values for custom levels
	default_waves = false
	
	runner_enemy_count_custom = 0
	runner_enemy_speed_custom = 100

	gunner_enemy_count_custom = 0
	bullet_speed_custom = 100
	bullet_damage_custom = 5

	max_player_health_custom = 100
	current_player_health = 100
	player_speed_custom = 100
	coin_amount = 0
	max_player_health_is_custom_made = 100
	max_dash_storage = 1
	current_dash_storage = 1
	dash_regain_time = 5

	pistol_shootwait_time_custom = 0.1
	player_pistol_bullet_damage = 5

	shotgun_shootwait_time_custom = 1
	shotgun_pellet_amount_custom = 4
	player_shotgun_pellet_damage = 5

	sniper_enemy_count_custom = 0
	sniper_charge_up_time_custom = 5 # in seconds 
	sniper_cooldown_time_custom = 4
	sniper_bullet_damage = 50
	
	#  ITEMS
	item_bomb_damage 
	current_player_bomb_amount = 0
