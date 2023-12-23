extends Area2D

const SPEED = 100
var left
var right

func _ready():
	set_process(true)
	
func _process(delta):	
	check_shoot()
	check_movement(delta)
	
func check_shoot():
	if Input.is_action_pressed("shoot"): shoot()
	
func check_movement(delta):
	var dir = 0
	if Input.is_action_pressed("go_right") and get_global_pos().x < 173: 
		dir += 1
	if Input.is_action_pressed("go_left") and get_global_pos().x > 7: 
		dir -= 1 
	translate(Vector2(1, 0) * SPEED * dir * delta)
	
func shoot():
	print('shoot')