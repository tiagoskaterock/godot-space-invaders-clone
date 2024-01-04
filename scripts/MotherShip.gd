extends Area2D

const is_player = false
const is_shield = false
const is_shoot = true
const _score = 500
const pre_alien_explosion = preload("res://scenes/AlienExplosion.tscn")

func _on_MotherShip_area_enter( area ):
	print(area)
	if area.is_shoot: 
		die(area)
		
func die(area):
	var game = get_parent()	
	game.setScore(game.getScore() + getSccore())
	area.queue_free() #some laser
	var alien_explosion = pre_alien_explosion.instance()
	alien_explosion.set_pos(Vector2(0,0))
	var transparente = Color(1,1,1,0)
	get_node("Sprite").modulate = transparente
	add_child(alien_explosion)

func getSccore():
	return _score
