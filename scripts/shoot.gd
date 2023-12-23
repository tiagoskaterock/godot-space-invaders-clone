extends Area2D

const SPEED = 180

func _ready():
	set_process(true)
	
func _process(delta):
	translate(Vector2(0, -1) * SPEED * delta)
	