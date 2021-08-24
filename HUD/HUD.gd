extends Control

var player
var level
var logoposition

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	
	if tree.has_group("Player"):
		player = tree.current_scene.get_node("Player")
		
	level = tree.current_scene.get_node("TileMap")
	
	logoposition = 12 # start with logo further down
	print(level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RichTextLabel.text = String(player.coins_collected) + "/" + String(level.coin_goal)
	$RichTextLabel2.bbcode_text = "[center]Level " + String(Global.current_level+1) + "[/center]"; 
	$Node2D.get_node("TimeLeftText").bbcode_text = str(Global.turns_left)
	
	if logoposition > -16: # float upwards until offscreen
		logoposition -= 0.05
		$Logo.position.y = min(4,logoposition) # so it waits a bit
