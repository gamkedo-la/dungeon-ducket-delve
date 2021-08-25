extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var frameskip = 3
var frame = 0
var skipped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$IntroTXT.visible_characters = 0

func _input(event):
	if event is InputEventKey and event.pressed:
		print("skipping intro text animation!")
		#print(event.scancode)
		skipped = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	frame += 1
	
	if frame % frameskip == 0:
		$IntroTXT.visible_characters += 1
		
	if skipped || $IntroTXT.visible_characters > $IntroTXT.text.length() + 20:
		hide()
		#$IntroGUI.hide() # stop displaying now
		#$IntroGUI.queue_free() # destroy it from the scene - FIXME: crashes
