extends Button

@onready var cash_sound_effect: AudioStreamPlayer = $"../../../../../cashSoundEffect"
@onready var incorrect_sound_effect: AudioStreamPlayer = $"../../../../../incorrectSoundEffect"


var coin_cost = 3
var max_level = 8
#Global.dash_regain_time
var value = -0.5
var changed_value

func _ready() -> void:
	if updatetracker.player_upg["player_faster_dash_level"] == max_level:
		disabled = true

func _on_pressed() -> void:
	var return_stuff = Global.buying_something(updatetracker.player_upg["player_faster_dash_level"], coin_cost, max_level, Global.dash_regain_time , value)
	Global.dash_regain_time = return_stuff[1]
	updatetracker.player_upg["player_faster_dash_level"] = return_stuff[2]
	
	if return_stuff[2] == max_level:
		disabled = true
	
	
	if return_stuff[0] == 1:
		cash_sound_effect.play()
	elif return_stuff[0] == 0:
		incorrect_sound_effect.play()
