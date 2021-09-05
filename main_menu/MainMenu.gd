extends Node2D

onready var transition_layer = $TransitionLayer
onready var credits_text = $CreditsText
onready var non_credits = $CreditsTip

onready var tween = Tween.new()

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	add_child(tween)
	if not transition_layer.is_connected("fade_out_complete", self, "switch_scenes"):
		assert(transition_layer.connect("fade_out_complete", self, "switch_scenes")== OK)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("credits"):
		_toggle_credits()
	if Input.is_action_just_pressed("ui_accept"):
		transition_layer.fade_out()
#	pass

func switch_scenes():
#	get_tree().change_scene("res://Levels/TutorialLevel.tscn")
	Global.goto_scene(Global.level_list[Global.current_level])

func _toggle_credits():
	if tween.is_active():
		tween.stop()
	if credits_text.rect_position.y > 150:		
		non_credits.set_visible(false)
		tween.interpolate_property(credits_text, "rect_position:y", 160, 0, 3, Tween.TRANS_EXPO, Tween.EASE_OUT)
		tween.start()
	else:
		non_credits.set_visible(true)
		tween.interpolate_property(credits_text, "rect_position:y", credits_text.rect_position.y, 160, .5, Tween.TRANS_EXPO, Tween.EASE_OUT)
		tween.start()

