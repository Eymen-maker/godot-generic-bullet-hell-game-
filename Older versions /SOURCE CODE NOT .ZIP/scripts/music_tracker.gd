extends Node2D
@onready var audio_stream_player: AudioStreamPlayer = $fight_music/AudioStreamPlayer
@onready var audio_stream_player_2: AudioStreamPlayer = $fight_music/AudioStreamPlayer2
@onready var audio_stream_player_3: AudioStreamPlayer = $menu_music/AudioStreamPlayer3
@onready var audio_stream_player_4: AudioStreamPlayer = $menu_music/AudioStreamPlayer4
@onready var audio_stream_player_5: AudioStreamPlayer = $shop_music/AudioStreamPlayer5


var fight_started = 0

func _ready() -> void:
	fight_started = 0
	audio_stream_player_3.play()
	audio_stream_player_3.finished.connect(_on_menu_intro_finished, CONNECT_ONE_SHOT)

func _menu_music_start():
	audio_stream_player.stop()
	audio_stream_player_2.stop()
	audio_stream_player_3.play()
	audio_stream_player_3.finished.connect(_on_menu_intro_finished, CONNECT_ONE_SHOT)

func _on_menu_intro_finished():
	audio_stream_player_4.play()

func _fight_music_start():
	audio_stream_player_3.stop()
	audio_stream_player_4.stop()
	audio_stream_player.play()
	audio_stream_player.finished.connect(_on_fight_intro_finished, CONNECT_ONE_SHOT)

func _on_fight_intro_finished():
	audio_stream_player_2.play()

func _shop_active():
	audio_stream_player_2.stream_paused = true
	audio_stream_player.stream_paused = true
	audio_stream_player_5.play()

func _shop_deactivated():
	audio_stream_player_2.stream_paused = false
	audio_stream_player.stream_paused = false
	audio_stream_player_5.stop()

func _stop_music():
	audio_stream_player.stop()
	audio_stream_player_2.stop()
	audio_stream_player_3.stop()
	audio_stream_player_4.stop()
	audio_stream_player_5.stop()

func _pause_fight_music():
	audio_stream_player_2.stream_paused = true

func _continue_fight_music():
	audio_stream_player_2.stream_paused = false
