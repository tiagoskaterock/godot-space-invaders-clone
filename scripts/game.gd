extends Node

var _score = 0
const preMotherShip = preload("res://scenes/MotherShip.tscn")
const maxToRespawnMothership = 30
const minToRespanMothership = 20

func _process(delta):
	var lives = get_node("Ship").getLives()
	
	# check lives and delete if it's needed
	if	lives == 2: hide_life('03')
	elif lives == 1: hide_life('02')
	elif lives == 0: hide_life('01')
	
func hide_life(which_life_to_hide):
	get_node("LifesGroup").get_node(which_life_to_hide).hide()	
	
func _ready():
	set_process(true)
	startTimerToMotherShip()
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	var window_position = (screen_size - window_size) / 2
	OS.set_window_position(window_position)

func startTimerToMotherShip():
	randomize()
	get_node("TimerToMotherShip").set_wait_time(rand_range(minToRespanMothership, maxToRespawnMothership))
	get_node("TimerToMotherShip").start()

func _on_TimerToMotherShip_timeout():
	ShowMotherShip()

func ShowMotherShip():	
	var motherShip = preMotherShip.instance()
	motherShip.set_pos(Vector2(300, 20))
	add_child(motherShip)
	get_node("TimerToMotherShip").stop()
	if motherShip.get_pos().x < 50:
		pass

func setScore(newScore):
	_score = newScore
	updateScoreOnScreen()

func getScore():
	return _score

func updateScoreOnScreen():
	get_node("HUD").updateScore(str(getScore()))
	
