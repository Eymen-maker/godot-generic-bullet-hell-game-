extends Button

@onready var cash_sound_effect: AudioStreamPlayer = $"../../../../../cashSoundEffect"
@onready var incorrect_sound_effect: AudioStreamPlayer = $"../../../../../incorrectSoundEffect"

# look at upg tracker
var coin_cost = 6
var max_level = 3
#Global.max_dash_storage
var value = 1
var changed_value

func _ready() -> void:
	if updatetracker.player_upg["player_dash_storage_level"] == max_level:
		disabled = true

func _on_pressed() -> void:
	var return_stuff = Global.buying_something(updatetracker.player_upg["player_dash_storage_level"], coin_cost, max_level, Global.max_dash_storage , value)
	Global.max_dash_storage = return_stuff[1]
	updatetracker.player_upg["player_dash_storage_level"] = return_stuff[2]
	
	if updatetracker.player_upg["player_dash_storage_level"] == max_level:
		disabled = true
	
	
	if return_stuff[0] == 1:
		cash_sound_effect.play()
	elif return_stuff[0] == 0:
		incorrect_sound_effect.play()
