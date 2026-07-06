extends Node2D

var score = 0
var player_healt = 100
var you_lost = 0
var player_bullet_touching = 0
var player_bullet_collider_name 



func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if score <= 0 :
		you_lost = 1
		
	
