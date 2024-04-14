extends Node2D

var pre_alien_laser = preload('res://scenes/AlienLaser.tscn')
var dir = -1
var y_speed = 3
var x_speed = 5 #pixels
var x_constant = 1
var maxIntervalToShoot = 5
var moving_group = false
var note = 1

func _ready():
	for alien in get_node("Aliens").get_children():
		alien.hide()
	
func shoot():
	get_node("SFX").play("ship_shoot")
	var total_aliens = get_node("Aliens").get_child_count()
	if total_aliens > 0:		
		var rand_alien = get_node("Aliens").get_child(randi() % total_aliens)		
		var laser = pre_alien_laser.instance()
		laser.set_pos(rand_alien.get_global_pos())
		get_parent().add_child(laser)

func _on_TimerToShoot_timeout():
	if moving_group:
		get_node("TimerToShoot").set_wait_time(rand_range(.5, maxIntervalToShoot))
		shoot()

func _on_TimerToMove_timeout():	
	var total_aliens = get_node("Aliens").get_child_count()	
	var wait_time = get_parent().get_node("TimerToMove").get_wait_time()
	
	if total_aliens == 20: 
		x_speed = 3 * x_constant
		accel_aliens(.8)
	if total_aliens == 15:
		x_speed = 4 * x_constant
	if total_aliens == 11:
		x_speed = 4 * x_constant
	if total_aliens == 8: 
		x_speed = 5 * x_constant
	if total_aliens == 7: 
		x_speed = 6 * x_constant
	if total_aliens == 6: 
		x_speed = 7 * x_constant
		accel_aliens(.7)
	if total_aliens == 5: 
		x_speed = 8 * x_constant
		accel_aliens(.6)
	if total_aliens == 4:
		x_speed = 9 * x_constant
	if total_aliens == 3:
		x_speed = 10 * x_constant
	if total_aliens == 2:
		accel_aliens(.5)
		x_speed = 11 * x_constant
	if total_aliens == 1: 
		accel_aliens(.3)
		x_speed = 12 * x_constant
	moveGroup()
	
func accel_aliens(wait_time):
	get_parent().get_node("TimerToMove").set_wait_time(wait_time)	

func moveGroup():
	# var total_aliens = get_node("Aliens").get_child_count()
	
	# after the intro 
	if moving_group:
		
		playSFXmove()
		
		for alien in get_node("Aliens").get_children():
			# alien.hide()
			alien.nextFrame()
			if alien.get_global_pos().x > 170:			
				translate(Vector2(0, y_speed))
				dir = -1
			elif alien.get_global_pos().x < 12:
				translate(Vector2(0, y_speed))
				dir = 1
		translate(Vector2(x_speed * dir, 0))
	
	# start when the group is not moving but showing aliens,  1 by 1
	if ! moving_group:
		for alien in get_node("Aliens").get_children():
			get_node("TimerPause").start()
			yield(get_node("TimerPause"), "timeout")
			alien.show()
		moving_group = true      

func playSFXmove():
	var total_aliens = get_node("Aliens").get_child_count()
	if total_aliens > 0:
		get_node("SFX").play(str(note))
		note = note + 1
		if note > 4: note = 1
	