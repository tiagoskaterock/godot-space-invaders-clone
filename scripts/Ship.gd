# Ship Script
extends Area2D

const SPEED = 100
var prev_shoot = preload("res://scenes/Shoot.tscn")
var prev_laser = false
const is_player = true
const is_shoot = false
const MAX_LIVES = 3
var lives = 3
var exploding = false
var infinite_shoot = false #for testing purposes

func _ready():
	get_node("Animation").play("default")
	set_process(true)
	
func _process(delta):	
	print(getLives())
	if lives < 1: return
	# check to see if all aliens are shown before the Ship can shoot
	var moving_group = get_parent().get_node("AlienGroup").moving_group
	if(moving_group):
		# check to see if ship is not exploding
		var animation = get_node("Animation").get_current_animation()
		if ! exploding:
			check_movement(delta)
			check_shoot()
	
func check_shoot():
	var shoot = Input.is_action_pressed("shoot")	
	if shoot and ! prev_laser and ! has_shoot_in_scene():
		var shoot = prev_shoot.instance()
		get_parent().add_child(shoot)
		shoot.set_global_pos(get_global_pos())
		get_node("SFX").play("ship_shoot")

	prev_laser = Input.is_action_pressed("shoot")
	
func has_shoot_in_scene():
	if infinite_shoot: return false;
	return get_tree().get_nodes_in_group("ship_shoot_group").size() != 0
	
func check_movement(delta):
	var dir = 0
	if Input.is_action_pressed("go_right") and get_global_pos().x < 173: 
		dir += 1
	if Input.is_action_pressed("go_left") and get_global_pos().x > 7: 
		dir -= 1 
	translate(Vector2(1, 0) * SPEED * dir * delta)
	
func die():
	explode()
	loseLife()
	
func explode():
	get_node("SFX").play("ship_explosion")
	exploding = true
	get_node("TimerExploding").start()
	get_node("Animation").play("explode")
	
func loseLife():
	setLives(getLives() - 1)

func updateLives(): 
	print('updateLives()')
	get_parent().get_node("HUD").updateLives(getLives())
	
func getLives(): return lives

func setLives(newLives):
	if newLives <= MAX_LIVES: 
		lives = newLives
		updateLives()
	
func addLife():
	if getLives() < MAX_LIVES:
		get_node("SFX").play("add_life")
		setLives(getLives() + 1)
	
func _on_TimerExploding_timeout():
	exploding = false
	get_node("Animation").play("default")

func _on_Ship_area_enter( area ):
	if area.has_method('is_enemy'):
		explode()
		setLives(0)
		get_parent().get_node("AlienGroup").moving_group = false
		
		
	
func is_ship(): return true
