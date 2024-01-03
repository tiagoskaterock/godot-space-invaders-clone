extends Area2D

var is_player = false
var is_shield = true

var frame = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func nextFrame():
	if frame < 5: 
		frame += 1
		get_node("Sprite").set_frame(frame)
	else: queue_free()
	
func _on_Shield_area_enter( area ):
	if area.is_shoot:
		nextFrame()
		area.queue_free()
	