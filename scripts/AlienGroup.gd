extends Node2D

var pre_alien_laser = preload('res://scenes/AlienLaser.tscn')

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
