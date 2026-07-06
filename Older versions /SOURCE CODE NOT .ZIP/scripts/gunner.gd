extends StaticBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cooldown_timer: Timer = $cooldownTimer
@onready var shooting_timer: Timer = $shootingTimer
@onready var character: CharacterBody2D = $"../character"
@onready var shootwait_timer: Timer = $shootwaitTimer
@onready var marker_2d: Marker2D = $Marker2D
@onready var place: Node2D = $".."


const BLOOD = preload("uid://tu05slnhq737")
var BULLET = preload("uid://cwvi3v41nbfdd")

var shooting = 0
var shootingTime = 3
var cooldownTime = 4
var shoot_agan = 1
var shootwait_time = 0.1
@export var local_char_health = 70

func _ready() -> void:
	cooldown_timer.start()

func _on_cooldown_timer_timeout() -> void:
	shooting = 1
	shooting_timer.start(shootingTime)

func _on_shooting_timer_timeout() -> void:
	shooting = 0
	cooldown_timer.start(cooldownTime)

func _on_shootwait_timer_timeout() -> void:
	shoot_agan = 1

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet"):
		get_damaged(area)


func _process(delta: float) -> void:
	
	# makes rot_degree restart at 360 to 0 
	var rotation_degrees2 = wrapf(rotation_degrees,0.0,360.0)
	if character:
		look_at(character.global_position)
	
	# it works / flips char when needed
	if rotation_degrees2 > 270:
		animated_sprite_2d.flip_v = false
	elif rotation_degrees2 > 90:
		animated_sprite_2d.flip_v = true
	elif rotation_degrees2 < 90:
		animated_sprite_2d.flip_v = false


	if shooting == 1:
		if shoot_agan == 1:
			animated_sprite_2d.play("shooting")
			# makes the bullet spawn looking at the player (aka marker_2d)
			var bullet = BULLET.instantiate()
			place.add_child(bullet)
			bullet.global_position = $Marker2D.global_position
			bullet.global_rotation = $Marker2D.global_rotation
			shootwait_timer.start(shootwait_time)
			shoot_agan = 0
		
	else:
		animated_sprite_2d.play("idle")




func get_damaged(area):
	if area.name == "player_bullet_area2d":
		local_char_health -= Global.player_bullet_damage
		Global.put_blood(place, BLOOD, global_position)
		did_i_die(local_char_health)
	
	elif area.name == "player_shotgun_pellet_area2d":
		local_char_health -= Global.player_shotgun_pellet_damage
		Global.put_blood(place, BLOOD, global_position)
		did_i_die(local_char_health)


func did_i_die(health):
	if health <= 0:
		queue_free()
