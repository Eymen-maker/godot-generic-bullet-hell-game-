extends Node2D


var original_player_upg = {
	"player_health_level" : 0,
	"health_coin_cost" : 5,
	"player_speed_level" : 0,
	"player_pistol_damage_level" : 0,
	"player_shotgun_firerate_level" : 0,
	"player_shotgun_pellet_count_level" : 0,
	"player_faster_dash_level" : 0,
	"player_dash_storage_level" : 0
}

var player_upg = original_player_upg.duplicate()

func _global_game_upg_reset():
	player_upg = original_player_upg.duplicate()
