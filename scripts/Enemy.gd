tool
extends Area2D

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
