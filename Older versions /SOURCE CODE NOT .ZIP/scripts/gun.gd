extends Node2D
@onready var place: Node2D = $"../.."
@onready var marker_2d: Marker2D = $Marker2D
@onready var pistol: Sprite2D = $Sprite2D
@onready var shotgun: Sprite2D = $Sprite2D2
@onready var pistol_shootwait_timer: Timer = $PistolShootwaitTimer
@onready var shotgun_shootwait_timer: Timer = $ShotgunShootwaitTimer


const PLAYER_BULLET = preload("uid://bcrm6jsd52xxb")
const PLAYER_SHOTGUN_BULLET = preload("uid://cnvobn7qkm7p7")

var shooting = 1
var shotgun_shooting = 1
var current_gun = "pistol"
@onready var current_sprite_2d = pistol


#Global.pistol_shootwait_time_custom = 0.1
#Global.shotgun_shootwait_time_custom = 1

func _on_pistol_shootwait_timer_timeout() -> void:
	shooting = 1

func _on_shotgun_shootwait_timer_timeout() -> void:
	shotgun_shooting = 1

func _ready() -> void:
	shotgun.visible = 0

func _process(_delta):
	var rotation_degrees2 = wrapf(rotation_degrees,0.0,360.0)

	if rotation_degrees2 > 270:
		current_sprite_2d.flip_v = false
	elif rotation_degrees2 > 90:
		current_sprite_2d.flip_v = true
	elif rotation_degrees2 < 90:
		current_sprite_2d.flip_v = false

	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)


	var player_pos = get_parent().global_position
	var dir = (mouse_pos - player_pos).normalized()

	position = dir * 20  # local position, parent'a göre offset
	
	if Input.is_action_just_pressed("switch_to_pistol"):
		current_gun = "pistol"
		pistol.visible = 1
		shotgun.visible = 0
		current_sprite_2d = pistol
	
	if Input.is_action_just_pressed("switch_to_shotgun"):
		current_gun = "shotgun"
		pistol.visible = 0
		shotgun.visible = 1
		current_sprite_2d = shotgun
	
	if current_gun == "pistol":
		if Input.is_action_just_pressed("m1"): # should make it togalable for holding
			if shooting == 1:
				var bullet = PLAYER_BULLET.instantiate()
				place.add_child(bullet)
				bullet.global_position = $Marker2D.global_position
				bullet.global_rotation = $Marker2D.global_rotation
				shooting = 0
				pistol_shootwait_timer.start(Global.pistol_shootwait_time_custom)
		

	elif current_gun == "shotgun":
		if Input.is_action_just_pressed("m1"):
			if shotgun_shooting == 1:
				randomize()
				for i in range(Global.shotgun_pellet_amount_custom):
					var shotgun_bullet = PLAYER_SHOTGUN_BULLET.instantiate()
					place.add_child(shotgun_bullet)
					shotgun_bullet.global_position = $Marker2D.global_position 
					shotgun_bullet.global_rotation_degrees = $Marker2D.global_rotation_degrees + randi_range(-30, 30)
				shotgun_shooting = 0
				shotgun_shootwait_timer.start(Global.shotgun_shootwait_time_custom)
				
