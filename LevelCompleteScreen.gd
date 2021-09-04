extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.level_list.size()-1 == Global.current_level:
		$RichTextLabel.text = "Game Complete! You Win Adventurer!"
	pass


func _on_Timer_timeout():
	Global.goto_next_level()
