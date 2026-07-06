extends Button

@onready var place: Node2D = $"/root/GAME/place"
@onready var game: Node2D = $"/root/GAME"
@onready var music_tracker: Node2D = $"/root/musicTracker"

const PLACE = preload("uid://d4beggoh7cs8k")

var custom_level = 0
var a
var b
var c
var d
var e
var f
var g
var h
var k  # i forgor
var l
var m

signal fight_music_start
signal restart_place_down_place

func _ready() -> void:
	if Global.custom_game_start == 1 or Global.default_waves == true:
		a = Global.sniper_enemy_count_custom 
		b = Global.sniper_charge_up_time_custom 
		c = Global.sniper_cooldown_time_custom
		
		d = Global.coin_amount 
		e = Global.max_player_health_custom 
		
		f =	Global.gunner_enemy_count_custom 
		g = Global.bullet_speed_custom 
		
		h = Global.runner_enemy_count_custom 
		k = Global.runner_enemy_speed_custom 
		
		l = Global.coin_amount_is_custom_made
		m = Global.max_player_health_is_custom_made 

func _on_pressed() -> void: # this was hell
	if Global.custom_game_start == 1 or Global.default_waves == true:
		Global.global_game_var_reset()
		
		Global.sniper_enemy_count_custom = a
		Global.sniper_charge_up_time_custom = b  
		Global.sniper_cooldown_time_custom = c
		
		if l != 0:
			Global.coin_amount = l
			Global.coin_amount_is_custom_made = l
		if m != 100:
			Global.max_player_health_custom = m
			Global.max_player_health_is_custom_made = m
		
		Global.gunner_enemy_count_custom = f 
		Global.bullet_speed_custom = g 
		
		Global.runner_enemy_count_custom = h 
		Global.runner_enemy_speed_custom = k 
		
		Global.custom_game_start = 1
		
	elif Global.custom_game_start == 0 or Global.default_waves == true:
		Global.global_game_var_reset()
	
	fight_music_start.connect(music_tracker._fight_music_start, CONNECT_ONE_SHOT)
	fight_music_start.emit()
	place.free()
	restart_place_down_place.connect(game._restart_place_down_place, CONNECT_ONE_SHOT)
	restart_place_down_place.emit()
	$"/root/GAME/you_lost".queue_free()
