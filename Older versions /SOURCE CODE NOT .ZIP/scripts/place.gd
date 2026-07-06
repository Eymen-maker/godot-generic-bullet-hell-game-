extends Node2D
@onready var place: Node2D = $"."

const PAUSED = preload("uid://8nkievx3x6x3")
const CHARACTER = preload("uid://cn1c6u6xra7ai")


var menu = false

func instantiating (scene):
	var scene2 = scene.instantiate()
	place.add_child(scene2)


	
func _ready() -> void:
	pass
	#var character = CHARACTER.instantiate()
	#place.add_child(character)
	



func _process(delta: float) -> void:
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
