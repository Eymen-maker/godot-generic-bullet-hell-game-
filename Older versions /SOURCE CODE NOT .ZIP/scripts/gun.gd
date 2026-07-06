extends Node2D
@onready var place: Node2D = $"../.."
@onready var marker_2d: Marker2D = $Marker2D

const PLAYER_BULLET = preload("uid://bcrm6jsd52xxb")

var shooting = 1

func _on_timer_timeout() -> void:
	shooting = 1


func _process(delta):
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)

	var player_pos = get_parent().global_position
	var dir = (mouse_pos - player_pos).normalized()

	position = dir * 20  # local position, parent'a göre offset
	
	if Input.is_action_just_pressed("m1"):
		if shooting == 1:
			var bullet = PLAYER_BULLET.instantiate()
			place.add_child(bullet)
			bullet.global_position = $Marker2D.global_position
			bullet.global_rotation = $Marker2D.global_rotation
