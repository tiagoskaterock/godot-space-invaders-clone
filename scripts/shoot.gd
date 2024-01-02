extends Area2D

const SPEED = 380
const is_shoot = true

func _ready():
	add_to_group("ship_shoot_group")
	set_process(true)
	
func _process(delta):
	translate(Vector2(0, -1) * SPEED * delta)
	
	if	get_global_pos().y < 0: queue_free()
	

	