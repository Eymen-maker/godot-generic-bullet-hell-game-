extends Button

@onready var cash_sound_effect: AudioStreamPlayer = $"../../../../../cashSoundEffect"
@onready var incorrect_sound_effect: AudioStreamPlayer = $"../../../../../incorrectSoundEffect"


var coin_cost = 10
var max_level = 3
#Global.shotgun_pellet_amount_custom
var value = 1
var changed_value

func _ready() -> void:
	if updatetracker.player_upg["player_shotgun_pellet_count_level"] == max_level:
		disabled = true

func _on_pressed() -> void:
	var return_stuff = Global.buying_something(updatetracker.player_upg["player_shotgun_pellet_count_level"], coin_cost, max_level, Global.shotgun_pellet_amount_custom , value)
	Global.shotgun_pellet_amount_custom = return_stuff[1]
	updatetracker.player_upg["player_shotgun_pellet_count_level"] = return_stuff[2]
	
	if return_stuff[2] == max_level:
		disabled = true
	
	
	if return_stuff[0] == 1:
		cash_sound_effect.play()
	elif return_stuff[0] == 0:
		incorrect_sound_effect.play()
