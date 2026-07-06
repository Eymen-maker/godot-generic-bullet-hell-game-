extends Button


@onready var cash_sound_effect: AudioStreamPlayer = $"../../../../../cashSoundEffect"
@onready var incorrect_sound_effect: AudioStreamPlayer = $"../../../../../incorrectSoundEffect"

# look at upg tracker
var coin_cost = 8
var max_level = 10000000
#Global.max_dash_storage
var value = 40
var changed_value


func _on_pressed() -> void:
	var return_stuff = Global.buying_something(Global.current_player_health, coin_cost, max_level, Global.current_player_health , value)
	Global.current_player_health = return_stuff[1]
	
	
	
	if return_stuff[0] == 1:
		cash_sound_effect.play()
	elif return_stuff[0] == 0:
		incorrect_sound_effect.play()
