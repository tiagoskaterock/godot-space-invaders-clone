extends Area2D

const is_player = false
const is_shield = false
const is_shoot = true
const _score = 500
const SPEED = 50
const pre_alien_explosion = preload("res://scenes/AlienExplosion.tscn")
var player_lives

func _ready():		
	get_node("CollisionPolygon2D").queue_free()
	get_node("SFX").play("sfx");
	set_process(true)

func _process(delta):
	player_lives = get_parent().get_node("Ship").lives
	if player_lives < 1 :
		var som = get_node("SFX")
		print(som.stop_all())
		#som.stop();
	else: 
		if get_pos().x < -20:
			queue_free()		
			restart()
		move(delta)
	
func restart():
	var game = get_parent()
	game.startTimerToMotherShip()

func _on_MotherShip_area_enter( area ):
	if area.is_shoot:
		die(area)

func die(area):
	# tira o colisor quando morre
	print(get_node("CollisionPolygon2D"))
	
	get_node("SFX").play("alien_explosion")
	var game = get_parent()	
	game.setScore(game.getScore() + getScore())
	area.queue_free() #some laser
	var alien_explosion = pre_alien_explosion.instance()
	alien_explosion.set_pos(Vector2(0,0))
	var transparente = Color(1,1,1,0)
	get_node("Sprite").modulate = transparente
	add_child(alien_explosion)
	restart()
	
func getScore():
	return _score

func move(delta):
	set_pos(Vector2(get_pos().x - (SPEED * delta), get_pos().y))
