extends Node

func _ready():
    center_game_on_screen()

func center_game_on_screen():
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	var window_position = (screen_size - window_size) / 2
	OS.set_window_position(window_position)