extends Node2D


func _ready():
	$AnimationPlayer.play("move_up")


func _on_AnimationPlayer_animation_finished(anim_name):
	if not get_parent().is_in_group("Chest"):
		get_parent().queue_free()
	else:
		queue_free()
	
