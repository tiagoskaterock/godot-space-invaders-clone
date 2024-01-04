extends Node

var _score = 0

func _ready():
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	var window_position = (screen_size - window_size) / 2
	OS.set_window_position(window_position)
	
func setScore(newScore):
	_score = newScore
	updateScoreOnScreen()	
	
func getScore():
	return _score
	
func updateScoreOnScreen():
	get_node("HUD").update(str(getScore()))
