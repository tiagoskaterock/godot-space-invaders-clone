extends Area2D

const SPEED = 100
var prev_shoot = preload("res://scenes/Shoot.tscn")
var prev_laser = false

func _ready():
	set_process(true)
	
func _process(delta):
	check_movement(delta)
	
	if Input.is_action_pressed("shoot") and ! prev_laser:		
		var shoot = prev_shoot.instance()
		get_parent().add_child(shoot)
		shoot.set_global_pos(get_global_pos())
		print(shoot.get_global_pos().y)
	
	prev_laser = Input.is_action_pressed("shoot")
		

func check_movement(delta):
	var dir = 0
	if Input.is_action_pressed("go_right") and get_global_pos().x < 173: 
		dir += 1
	if Input.is_action_pressed("go_left") and get_global_pos().x > 7: 
		dir -= 1 
	translate(Vector2(1, 0) * SPEED * dir * delta)
	