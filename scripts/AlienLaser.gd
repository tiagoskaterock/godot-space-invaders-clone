extends Area2D

const SPEED = 100
const is_shoot = true

func _ready():
	set_process(true)
	
func _process(delta):
	translate(Vector2(0, 1) * SPEED * delta)
	if get_global_pos().y > 400: queue_free()	

func _on_AlienLaser_area_enter( area ):
	print(area.get_name())
	if area.is_player: 
		area.die()
		queue_free()
	else:
		area.queue_free()
		queue_free()
		
