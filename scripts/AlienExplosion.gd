extends Node2D

func _on_AnimationPlayer_finished():
	get_parent().queue_free()
