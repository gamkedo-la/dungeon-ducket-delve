extends Node2D

var transition_layer
var credits_text
var non_credits
func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()

	credits_text = tree.current_scene.get_node("CreditsText")
	credits_text.set_visible(false);
	non_credits = tree.current_scene.get_node("HideForCredits")
	transition_layer = tree.current_scene.get_node("TransitionLayer")
	transition_layer.connect("fade_out_complete", self, "switch_scenes")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("credits"):
		credits_text.set_visible(credits_text.is_visible()==false);
		non_credits.set_visible(credits_text.is_visible()==false);
	if Input.is_action_just_pressed("ui_accept"):
		transition_layer.fade_out()
#	pass

func switch_scenes():
#	get_tree().change_scene("res://Levels/TutorialLevel.tscn")
	Global.goto_scene(Global.level_list[Global.current_level])
	
