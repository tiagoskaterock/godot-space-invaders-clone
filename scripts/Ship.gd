# Ship Script
extends Area2D

const SPEED = 100
var prev_shoot = preload("res://scenes/Shoot.tscn")
var prev_laser = false
const is_player = true
var lives = 3

func _ready():
	set_process(true)
	
func _process(delta):
	# check to see if all aliens are shown before the Ship can shoot
	var moving_group = get_parent().get_node("AlienGroup").moving_group
	if(moving_group):
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
	
func loseLife():
	setLives(getLives() - 1)	
	var hud = get_parent().get_node("HUD")
	hud.updateLives(getLives())
	
func getLives():
	return lives
	
func setLives(newLives):
	lives = newLives
	