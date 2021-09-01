extends Node2D

var greet_content = Narrative.CSVToArray("res://Narrative/Greet.txt")
var content_to_display = []

func _ready():
	display_text_box(greet_content)
	
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
	queue_free()

