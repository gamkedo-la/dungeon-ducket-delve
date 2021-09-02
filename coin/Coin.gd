extends Node2D


func _ready():
	$AnimationPlayer.play("move_up")


func _on_AnimationPlayer_animation_finished(anim_name):
	if get_parent().name != "Chest":
		get_parent().queue_free()
	else:
		queue_free()
	
