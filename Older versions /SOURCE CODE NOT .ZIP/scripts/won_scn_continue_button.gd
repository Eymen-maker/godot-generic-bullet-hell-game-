extends Button

@onready var place: Node2D = $"/root/GAME/place"
@onready var game: Node2D = $"/root/GAME"
@onready var music_tracker: Node2D = $"/root/musicTracker"
@onready var you_won: Node2D = $"../.."

signal continue_fight_music

func _on_pressed() -> void:
	continue_fight_music.connect(music_tracker._continue_fight_music, CONNECT_ONE_SHOT)
	continue_fight_music.emit()
	place.process_mode = Node.PROCESS_MODE_INHERIT
	you_won.queue_free()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		continue_fight_music.connect(music_tracker._continue_fight_music, CONNECT_ONE_SHOT)
		continue_fight_music.emit()
		place.process_mode = Node.PROCESS_MODE_INHERIT
		you_won.queue_free()
