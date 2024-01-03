extends Area2D

const SPEED = 100
var prev_shoot = preload("res://scenes/Shoot.tscn")
var prev_laser = false
const is_player = true
var lives = 3

func _ready():
	set_process(true)
	
func _process(delta):
	check_movement(delta)
	check_shoot()
	
func check_shoot():
	var shoot = Input.is_action_pressed("shoot")	
	if shoot and ! prev_laser and ! has_shoot_in_scene():		
		var shoot = prev_shoot.instance()
		get_parent().add_child(shoot)
		shoot.set_global_pos(get_global_pos())

	prev_laser = Input.is_action_pressed("shoot")
	
func has_shoot_in_scene():
	return get_tree().get_nodes_in_group("ship_shoot_group").size() != 0
	
func check_movement(delta):
	var dir = 0
	if Input.is_action_pressed("go_right") and get_global_pos().x < 173: 
		dir += 1
	if Input.is_action_pressed("go_left") and get_global_pos().x > 7: 
		dir -= 1 
	translate(Vector2(1, 0) * SPEED * dir * delta)
	
func die():
	loseLife()
	print("Lives:" + str(lives))
	print('PLAYER DIES')
	
func loseLife():
	lives -= 1
	queue_free()	
	