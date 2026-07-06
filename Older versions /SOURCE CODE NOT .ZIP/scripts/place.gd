extends Node2D
@onready var place: Node2D = $"."

const RUNNING_ENEMY = preload("uid://737nfnejgfu3")
const PAUSED = preload("uid://8nkievx3x6x3")
const CHARACTER = preload("uid://cn1c6u6xra7ai")
const GUNNER = preload("uid://by4ohy3k871gm")
const PLAYER_HEALT = preload("uid://cliqckcq3pmf7")



var menu = false

func instantiating (scene):
	var scene2 = scene.instantiate()
	place.add_child(scene2)
	scene2.global_position =  Vector2(float(randi_range(-400, 400)), float(randi_range(-300, 300)))



func _ready() -> void:
	randomize()

	var character = CHARACTER.instantiate()
	place.add_child(character)
	var player_health = PLAYER_HEALT.instantiate()
	place.add_child(player_health)
	
	for i in range(Global.runner_enemy_count_custom):
		instantiating(RUNNING_ENEMY)
	
	for i in range(Global.gunner_enemy_count_custom):
		instantiating(GUNNER)



func _process(_delta: float) -> void:
	pass
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	#if menu == false:
	#	if Input.is_action_just_pressed("pause"):
	#		var paused_menu = PAUSED.instantiate()
	#		add_child(paused_menu)
	#		menu = true
	
	#if menu == true :
	#	if Input.is_action_just_pressed("pause"):
	#		var paused_menu = PAUSED.instantiate()
	#		add_child(paused_menu)
	#		menu = false
