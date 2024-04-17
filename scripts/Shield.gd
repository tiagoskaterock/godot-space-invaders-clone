extends Area2D

var is_player = false
var is_shield = true
var is_shoot = false

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
	
# shield atingido
func _on_Shield_area_enter( area ):
	# shield atingido por inimigo para o jogo
	if area.has_method('is_enemy') and area.is_enemy():
		get_node("SFX").play("ship_explosion")
		get_node("Sprite").set_frame(4)
		stop_game()
		
	#shield atingido por míssel apenas quebra aos poucos
	if area.is_shoot:
		nextFrame()
		area.queue_free()
		get_node("SFX").play("InvaderHit")
		
# para o jogo e dá game over
func stop_game():
	get_parent().get_node("AlienGroup").player_is_dead = true
	get_parent().get_node("Ship").lives = 0;
	print('game over')
	