extends Control

#Test Commit - Hello gitbot!

# why three quotes? they let you have multi-line strings in code
var INTROS = [

# level 1
"""Dungeon Level One

Welcome to the dungeon!
We've got turn-based fun.
You can have any duckets you find
but you'd better stay on the run!

It's a very lethal place!
Grabbing coins is not a crime!
Kick that chest and grab your loot
before you run out of time!""",

# level 2
"""Dungeon Level Two Intro""",

# level 3
"""Dungeon Level Three Intro""",

# level 4
"""Dungeon Level Four Intro""",

# level 5
"""Dungeon Level Five Intro""",

# level 6
"""Dungeon Level Six Intro""",

# level 7
"""Dungeon Level Seven Intro""",

# level 8
"""Dungeon Level Eight Intro"""]


var frameskip = 3
var frame = 0
var skipped = false
var lastIntroducedLevel = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	$IntroTXT.visible_characters = 0

func _input(event):
	if event is InputEventKey and event.pressed:
		#print("skipping intro text animation!")
		#print(event.scancode)
		skipped = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#detect a scene change
	if Global.current_level != lastIntroducedLevel:
		frame = 0
		skipped = false
		lastIntroducedLevel = Global.current_level
		print("starting INTRO TEXT for level "+str(lastIntroducedLevel))
		print($IntroTXT.text)
		$IntroTXT.text = INTROS[lastIntroducedLevel % INTROS.size()]
		$IntroTXT.visible_characters = 0

	frame += 1
	
	if frame % frameskip == 0:
		$IntroTXT.visible_characters += 1
		
	if skipped || $IntroTXT.visible_characters > $IntroTXT.text.length() + 40:
		hide()
		#$IntroGUI.hide() # stop displaying now
		#$IntroGUI.queue_free() # destroy it from the scene - FIXME: crashes
