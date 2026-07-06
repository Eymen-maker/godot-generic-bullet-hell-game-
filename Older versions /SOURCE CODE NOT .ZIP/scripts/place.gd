extends Node2D
@onready var place: Node2D = $"."
@onready var game: Node2D = $".."
#@onready var character: CharacterBody2D = $"character"

const RUNNING_ENEMY = preload("uid://737nfnejgfu3")
const PAUSED = preload("uid://8nkievx3x6x3")
const CHARACTER = preload("uid://cn1c6u6xra7ai")
const GUNNER = preload("uid://by4ohy3k871gm")
const PLAYER_HEALT = preload("uid://cliqckcq3pmf7")
const SNIPER = preload("uid://c40r31hab7ib0")

# wave_spawner is at the bottom

var menu = false
var new_wave = true
var tutorial_level = 0

var once = 1

var runner
var gunner
var sniper


func _ready() -> void:
	if Global.tutorial == true:
		tutorial_level = 1
		
	var character2 = CHARACTER.instantiate()
	place.add_child(character2)
	var player_health = PLAYER_HEALT.instantiate()
	place.add_child(player_health)


func _process(_delta: float) -> void:
	if Global.tutorial == true:
		if tutorial_level == 1:
			if once == 1:
				enemy_counts(1,0,0)
				wave_spawner()
				once = 0
			elif enemys_left() == 0:
				tutorial_level = 2
				once = 1
		if tutorial_level == 2:
			if once == 1:
				enemy_counts(0,1,0)
				wave_spawner()
				once = 0
			elif enemys_left() == 0:
				tutorial_level = 3
				once = 1
		if tutorial_level == 3:
			if once == 1:
				enemy_counts(0,0,1)
				wave_spawner()
				once = 0
			elif enemys_left() == 0:
				tutorial_level = 4
				once = 1
				Global.tutorial = false # update this when new tutorial level
	
	elif enemys_left() == 0:
		
		Global.current_player_health = Global.max_player_health_custom
		Global.wave += 1
		Global.wave_power = (Global.wave + 3) * 2 # VERY İMPORTANT, also linear <===============================
		print(Global.wave)
		
		
		reset_enemies()
		while Global.wave_power >= 5:
			wave_enemy_calculator()
		enemy_counts(runner,gunner,sniper)
		wave_spawner()
		# can make a level chooser by using awards aka max level
		

	if Global.menu_status == 0:
		if Input.is_action_just_pressed("pause"):
			var paused_menu = PAUSED.instantiate()
			game.add_child(paused_menu)
			Global.menu_status = 1
			place.process_mode = Node.PROCESS_MODE_DISABLED


func wave_enemy_calculator():
	randomize()
	
	if Global.wave_power >= 8:
		if randf() < 0.2:
			Global.wave_power -= 10
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
	
	if not Global.custom_game_start:
		Global.runner_enemy_count_custom = a 
		Global.gunner_enemy_count_custom = b
		Global.sniper_enemy_count_custom = c
	else:
		pass # spawning also uses globals so no need for them agan

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
