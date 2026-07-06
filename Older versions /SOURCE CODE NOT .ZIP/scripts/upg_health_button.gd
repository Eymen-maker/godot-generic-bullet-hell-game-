extends Button
@onready var cash_sound_effect: AudioStreamPlayer = $"../../../../../cashSoundEffect"
@onready var incorrect_sound_effect: AudioStreamPlayer = $"../../../../../incorrectSoundEffect"


#updatetracker.player_upg["health_coin_cost"]
var max_level = 15
#Global.max_player_health_custom
var value = +20
var changed_value

func _ready() -> void:
	if updatetracker.player_upg["player_health_level"] == max_level:
		disabled = true
	text = "max health +20\n------ " + str(updatetracker.player_upg["health_coin_cost"]) + " coins"

func _on_pressed() -> void:
	var return_stuff = Global.buying_something(updatetracker.player_upg["player_health_level"], updatetracker.player_upg["health_coin_cost"], max_level, Global.max_player_health_custom , value)
	Global.max_player_health_custom = return_stuff[1]
	updatetracker.player_upg["player_health_level"] = return_stuff[2]
	
	if return_stuff[2] == max_level:
		disabled = true
		
	
	if return_stuff[0] == 1:
		cash_sound_effect.play()
		# you might want to change this
		updatetracker.player_upg["health_coin_cost"] = updatetracker.player_upg["health_coin_cost"] + int((updatetracker.player_upg["player_health_level"]) /2)
	elif return_stuff[0] == 0:
		incorrect_sound_effect.play()
	
	
	
	text = "max health +20\n------ " + str(updatetracker.player_upg["health_coin_cost"]) + " coins"
	
