extends Node2D
@onready var place: Node2D = $"."
@onready var game: Node2D = $".."
@onready var music_tracker: Node2D = $"/root/musicTracker"
#@onready var character: CharacterBody2D = $"character"

const RUNNING_ENEMY = preload("uid://737nfnejgfu3")
const PAUSED = preload("uid://8nkievx3x6x3")
const CHARACTER = preload("uid://cn1c6u6xra7ai")
const GUNNER = preload("uid://by4ohy3k871gm")
const PLAYER_HEALT = preload("uid://cliqckcq3pmf7")
const SNIPER = preload("uid://c40r31hab7ib0")
const SHOP = preload("uid://hijl7k27qmp")
const YOU_LOST = preload("uid://3meeh85m22f7")
const YOU_WON = preload("uid://b2xmi3fep0put")

# wave_spawner is at the bottom

var menu = false
var new_wave = true
var tutorial_level = 0

var once = 1
var tut_action_done 

var runner
var gunner
var sniper

signal shop_active
signal stop_music
signal pause_fight_music

func _ready() -> void:
	if Global.tutorial == true:
		tutorial_level = 1
		
	var character2 = CHARACTER.instantiate()
	place.add_child(character2)
	var player_health = PLAYER_HEALT.instantiate()
	place.add_child(player_health)


func _process(_delta: float) -> void:
	
	if Global.tutorial == true:
		Global.current_player_health = 100000
		Global.max_player_health_custom = 100000
		if tutorial_level == 1: # runner enemy
			if once == 1:
				enemy_counts(1,0,0)
				wave_spawner()
				once = 0
			elif enemys_left() == 0:
				tutorial_level = 2
				once = 1
		if tutorial_level == 2: # gunner enemy
			if once == 1:
				enemy_counts(0,1,0)
				wave_spawner()
				once = 0
			elif enemys_left() == 0:
				tutorial_level = 3
				once = 1
		if tutorial_level == 3: # sniper enemy
			if once == 1:
				enemy_counts(0,0,1)
				wave_spawner()
				once = 0
			elif enemys_left() == 0:
				tutorial_level = 4
				once = 1
		if tutorial_level == 4: # shotgun 
			if Input.is_action_just_pressed("switch_to_shotgun"):
				tut_action_done = 1
			if once == 1:
				enemy_counts(0,1,0)
				wave_spawner()
				once = 0
			elif enemys_left() == 0:
				if tut_action_done == 1:
					tut_action_done = 0
					tutorial_level = 5
					once = 1
		if tutorial_level == 5: # shop
			if Input.is_action_just_pressed("shop"):
				tut_action_done = 1
			if once == 1:
				enemy_counts(0,1,0)
				wave_spawner()
				once = 0
			elif enemys_left() == 0:
				if tut_action_done == 1:
					tut_action_done = 0
					tutorial_level = 6
					once = 1
		if tutorial_level == 6: # bomb
			if Input.is_action_just_pressed("throw bomb"):
				tut_action_done = 1
			if once == 1:
				Global.coin_amount = 9999
				enemy_counts(0,1,0)
				wave_spawner()
				once = 0
			elif enemys_left() == 0:
				if tut_action_done == 1:
					tut_action_done = 0
					tutorial_level = 7
					once = 1
		if tutorial_level == 7: # parry
			if Input.is_action_just_pressed("parry"):
				tut_action_done = 1
			if once == 1:
				Global.coin_amount = 9999
				enemy_counts(0,4,0)
				wave_spawner()
				once = 0
			elif enemys_left() == 0:
				if tut_action_done == 1:
					tut_action_done = 0
					tutorial_level = 8
					once = 1
		if tutorial_level == 8: # dash
			if Input.is_action_just_pressed("dash"):
				tut_action_done = 1
			if once == 1:
				enemy_counts(0,1,0)
				wave_spawner()
				once = 0
			elif enemys_left() == 0:
				if tut_action_done == 1:
					tut_action_done = 0
					tutorial_level = 9
					once = 1
					Global.global_game_var_reset()
					Global.tutorial = false # update this when new tutorial level
	
	
	elif Global.custom_game_start == 1:
		if Global.custom_no_enemies_game == 0:
			if enemys_left() == 0:
				Global.wave += 1
				once = 0
				Global.current_player_health = Global.max_player_health_custom
				wave_spawner()
				if enemys_left() == 0:
					Global.custom_no_enemies_game = 1
	
	
	
	elif enemys_left() == 0:
		Global.current_player_health = Global.max_player_health_custom
		Global.wave += 1
		if Global.wave == 31: # win scene
			pause_fight_music.connect(music_tracker._pause_fight_music, CONNECT_ONE_SHOT)
			pause_fight_music.emit()
			var you_won = YOU_WON.instantiate()
			game.add_child(you_won)
			place.process_mode = Node.PROCESS_MODE_DISABLED
		
		Global.wave_power = (Global.wave + 3) * 2 # VERY İMPORTANT, also linear <===============================
		
		
		
		reset_enemies()
		while Global.wave_power >= 5:
			wave_enemy_calculator()
		enemy_counts(runner,gunner,sniper)
		if Global.wave != 31:
			wave_spawner()
		# can make a level chooser by using awards aka max level


	if Global.menu_status == 0:
		if Input.is_action_just_pressed("pause"):
			var paused_menu = PAUSED.instantiate()
			game.add_child(paused_menu)
			Global.menu_status = 1
			place.process_mode = Node.PROCESS_MODE_DISABLED
	
	if Global.current_player_health <= 0:
		stop_music.connect(music_tracker._stop_music, CONNECT_ONE_SHOT)
		stop_music.emit()
		var you_lost = YOU_LOST.instantiate()
		game.add_child(you_lost)
		place.process_mode = Node.PROCESS_MODE_DISABLED
	
	
	
	# shop button is g
	if Global.shop_status == 0:
		if Input.is_action_just_pressed("shop"):
			var shop = SHOP.instantiate()
			game.add_child(shop)
			Global.shop_status = 1
			place.process_mode = Node.PROCESS_MODE_DISABLED
			shop_active.connect(music_tracker._shop_active, CONNECT_ONE_SHOT)
			shop_active.emit()

func wave_enemy_calculator():
	randomize()
	
	if Global.wave_power >= 8:
		if randf() < 0.2:
			Global.wave_power -= 8
			sniper += 1
	
	if Global.wave_power >= 5:
		if randf() < 0.5:
			Global.wave_power -= 5
			gunner += 1
	
	if runner < 4:
		if Global.wave_power >= 2:
			if randf() < 0.8 / (runner * 2):
				Global.wave_power -= 2 + runner
				runner += 1

func reset_enemies():
		runner = 0 
		gunner = 0
		sniper = 0

func enemy_counts (a, b, c):
		Global.runner_enemy_count_custom = a 
		Global.gunner_enemy_count_custom = b
		Global.sniper_enemy_count_custom = c

func enemys_left():
	return get_tree().get_nodes_in_group("enemies").size()

func wave_spawner() -> void:
	
	for i in range(Global.runner_enemy_count_custom):
		instantiating(RUNNING_ENEMY)
	
	for i in range(Global.gunner_enemy_count_custom):
		instantiating(GUNNER)
		
	for i in range(Global.sniper_enemy_count_custom):
		instantiating(SNIPER)

func instantiating (scene):
	randomize()
	var scene2 = scene.instantiate()
	place.add_child(scene2)
	scene2.global_position =  Vector2(float(randi_range(-400, 400)), float(randi_range(-300, 300)))
