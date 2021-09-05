extends Node2D

#var greet_content = Narrative.CSVToArray("res://Narrative/Greet.txt")
var arr = [["", 2, "How's it going?", "Good", "Great","" , "Bad", "Uh oh","" , "Bye!"], ["", 2, "What it do?", "Not much", "Cool", "", "You know", "I do", "", "Later!"], ["", 2, "I wish I had more duckets.", "Me too!", "Well you can't have any of mine.", "", "Why?", "None of your business!", "", "Fine."]]

var content_to_display = []

func _ready():
	Global.in_conversation_mode = true
	display_text_box(arr)
	
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		queue_free()

func display_text_box(content):
	content_to_display = Narrative.GetContent(content)
	
	$Content.text = content_to_display[Narrative.CONTENT]
	$YesOption.text = content_to_display[Narrative.YES_ANSWER]
	$NoOption.text = content_to_display[Narrative.NO_ANSWER]

func _on_YesOption_pressed():
	$YesOption.visible = false
	$Done.text = content_to_display[Narrative.DONE_TEXT]
	$Done.visible = true
	$Content.text = content_to_display[Narrative.YES_RESPONSE]
	
func _on_NoOption_pressed():
	$YesOption.visible = false
	$NoOption.visible = false
	$Done.text = content_to_display[Narrative.DONE_TEXT]
	$Done.visible = true
	$Content.text = content_to_display[Narrative.NO_RESPONSE]

func _on_Done_pressed():
	Global.in_conversation_mode = false
	queue_free()

