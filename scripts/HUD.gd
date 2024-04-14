extends Node

func updateScore(text):
	get_node("ScoreLabel").set_text(str(text))
	
func updateLives(text):
	return
	# get_node("LivesLabel").set_text("LIVES: " + str(text))
	