tool
extends Area2D
var frame = 0
var pre_alien_explosion = preload('res://scenes/AlienExplosion.tscn')

export (int, "A", "B", "C") var type = 0 setget setType

var attributes = [
	{
		'texture': preload("res://sprites/InvaderA_sheet.png"),
		'score': 10
	},
	{
		'texture': preload("res://sprites/InvaderB_sheet.png"),
		'score': 20
	},
	{
		'texture': preload("res://sprites/InvaderC_sheet.png"),
		'score': 30
	},
]

func _ready():
	pass
	
func _draw():
	get_node("Sprite").set_texture(attributes[type].texture)
	var score = attributes[type].score
	
func setType(val):
	type = val
	if is_inside_tree() and get_tree().is_editor_hint():
		update()

func _on_Enemy_area_enter( area ):
	if area.is_shoot: 
		area.queue_free() #some laser
		var alien_explosion = pre_alien_explosion.instance()
		print(get_global_pos())
		alien_explosion.set_pos(Vector2(0,0))
		var transparente = Color(1,1,1,0)
		get_node("Sprite").modulate = transparente
		add_child(alien_explosion)
#		queue_free() #some inimigo
		
func nextFrame():	
	if frame == 0: frame = 1
	else: frame = 0
	get_node("Sprite").set_frame(frame)
