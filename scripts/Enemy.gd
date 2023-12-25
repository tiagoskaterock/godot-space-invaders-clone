extends Area2D

export (int, "A", "B", "C") var type = 0

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
	get_node("Sprite").set_texture(attributes[type].texture)
	var score = attributes[type].score
