extends CharacterBody2D
@onready var line: Line2D = $Line2D
@onready var character: CharacterBody2D = $"../../character"
@onready var marker: Marker2D = $"../Marker2D"
@onready var chargeup_timer: Timer = $chargeupTimer
@onready var place: Node2D = $"../.."
@onready var warning_timer: Timer = $warningTimer

const SNIPER_BULLET = preload("uid://cm28ic8yf6k1o")

var shoot = 0
var warning = 0
@export var aim_guessing = 30 # also look at sniper scene
var where_player_will_be

func _ready() -> void:
	chargeup_timer.start(Global.sniper_charge_up_time_custom)
	warning_timer.start(Global.sniper_charge_up_time_custom - 0.2)

func _on_chargeup_timer_timeout() -> void:
	shoot = 1

func _on_warning_timer_timeout() -> void:
	line.default_color = Color(1.0, 1.0, 0.0, 1.0)
	warning = 1
	

func _process(delta: float) -> void:
	line.clear_points()
	line.add_point(to_local(marker.global_position))
	if warning == 1:
		where_player_will_be = character.global_position + (Global.player_direction * aim_guessing)
		line.add_point(to_local(where_player_will_be))
	else:
		line.add_point(to_local(character.global_position))
		
	# sends parent warning var
	get_parent().warning_light = warning
	get_parent().where_player_will_be = where_player_will_be
	
	if shoot == 1:
		var sniper_bullet = SNIPER_BULLET.instantiate()
		place.add_child(sniper_bullet)
		sniper_bullet.global_position = global_position
		sniper_bullet.global_rotation = global_rotation 
		line.default_color = Color(1.0, 0.0, 0.0, 1.0)
		warning = 0
		get_parent().warning_light = warning # there is a reason there is two of these
		queue_free()
