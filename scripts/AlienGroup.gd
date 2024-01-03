extends Node2D

var pre_alien_laser = preload('res://scenes/AlienLaser.tscn')
var dir = -1
var y_speed = 3
var x_speed = 2
var x_constant = 3

func _ready():
	pass
	
func shoot():	
	var total_aliens = get_node("Aliens").get_child_count()
	if total_aliens > 0:		
		var rand_alien = get_node("Aliens").get_child(randi() % total_aliens)		
		var laser = pre_alien_laser.instance()
		laser.set_pos(rand_alien.get_global_pos())
		get_parent().add_child(laser)

func _on_TimerToShoot_timeout():
	get_node("TimerToShoot").set_wait_time(rand_range(.5, 5))
	shoot()

func _on_TimerToMove_timeout():	
	var total_aliens = get_node("Aliens").get_child_count()
	print(total_aliens)	
	if total_aliens == 20: x_speed = 3 * x_constant
	if total_aliens == 15: x_speed = 4 * x_constant
	if total_aliens == 11: x_speed = 4 * x_constant
	if total_aliens == 8: x_speed = 5 * x_constant
	if total_aliens == 7: x_speed = 6 * x_constant
	if total_aliens == 6: x_speed = 7 * x_constant
	if total_aliens == 5: x_speed = 8 * x_constant
	if total_aliens == 4: x_speed = 9 * x_constant
	if total_aliens == 3: x_speed = 10 * x_constant
	if total_aliens == 2: x_speed = 11 * x_constant
	if total_aliens == 1: x_speed = 12 * x_constant
	
	moveGroup()
	
func moveGroup():
	for alien in get_node("Aliens").get_children():
		if alien.get_global_pos().x > 170:
			translate(Vector2(0, y_speed))
			dir = -1
		elif alien.get_global_pos().x < 12:
			translate(Vector2(0, y_speed))
			dir = 1
	translate(Vector2(x_speed * dir, 0))
