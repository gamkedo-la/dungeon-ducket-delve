extends Control

# why three quotes? they let you have multi-line strings in code
var INTROS = [

# level 1
"""Dungeon Ducat Delve

Welcome to the dungeon!
We've got turn-based fun.
You can have any duckets you find
but you'd better stay on the run!

It's a very lethal place!
Grabbing coins is not a crime!
Kick that chest and grab your loot
before you run out of time!""",

# level 2
"""Our hero awakes in a dungeon.

"How’d I end up here…"
The hero looks around and a
voice in their head wonders,
"but… why a dungeon?.."

They pause, "Nevermind that!
There are duckets to be found!"
""",

# level 3
"""The hero descends to the next
level of the dungeon. "I need
to have all of my faculties
at the ready. It’s like my
grandmother used to say,
there’s more than one way
to skin a ducket…
or something like that.” 
""",
#The voice in their head says, “what does that even mean?”
#The hero says, “Beats me. I’m not even sure what skinning a ducket would look like”

# level 4
"""Down another set of stairs the
hero goes. The voice in their head
says, "Watch your step. It’s
important to keep your footing!"
"Good thinking," says the hero. 
"Look, if you’re going to keep
showing up, I’m going to need a
name for you. Let’s go with Barnabus."
""",

# level 5
"""
"You know, Barnabus, I hadn’t
considered how we’re going to
carry all these duckets back up
these stairs. I wonder if
encumbrance is tracked somewhere?"
Barnabus replies, “That’s a
good point. Here I was thinking
I was asking the hard questions.
I wonder what the designers
think?” The hero attempts to
make eye contact with you.
“Just as I suspected. You’re a
player, not a designer. Well
then, I guess it’s of no concern.”
""",

# level 6
"""Dungeon Level Six""",

# level 7
"""Dungeon Level Seven""",

# level 8
"""Dungeon Level Eight"""]


var frameskip = 2
var frame = 0
var skipped = false
var lastIntroducedLevel = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	$IntroTXT.visible_characters = 0
	show()

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
		$IntroTXT.text = INTROS[lastIntroducedLevel % INTROS.size()]
		print($IntroTXT.text)
		$IntroTXT.visible_characters = 0
		show()

	frame += 1
	
	if frame % frameskip == 0:
		$IntroTXT.visible_characters += 1
		
	if skipped || $IntroTXT.visible_characters > $IntroTXT.text.length() + 40:
		hide()
		#$IntroGUI.hide() # stop displaying now
		#$IntroGUI.queue_free() # destroy it from the scene - FIXME: crashes
