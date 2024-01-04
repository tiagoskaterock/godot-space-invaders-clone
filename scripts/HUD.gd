extends Node

func updateScore(text):
	get_node("ScoreLabel").set_text("SCORE: " + str(text))
	
func updateLives(text):
	get_node("LivesLabel").set_text("LIVES: " + str(text))
	