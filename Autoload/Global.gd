extends Node

var current_scene = null
var debug_mode = false
var current_level = 0
const level_list = ["res://Levels/TutorialLevel.tscn", "res://Levels/TutorialLevel_2.tscn", "res://Levels/main.tscn", "res://Levels/Level 2.tscn", "res://Levels/Town Level.tscn"]
var turns_left = 50
var in_conversation_mode = false

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_next_level():
	if level_list.size()-1 > current_level:
		current_level += 1
		goto_scene(level_list[current_level])
	else:
		print_debug("Global.gd: you win; what do?")


func goto_scene(path):
	# Defer the load until the current scene is done executing code
	print_debug("Getting to goto_scene " + path)
	get_tree().change_scene(path)
#	call_deferred("_deferred_goto_scene", path)


# A function to simplify reparenting nodes, a function that will likely happen a lot as we design things "Modularly"
func reparent(child: Node, new_parent: Node):
	if child:
		var old_parent = child.get_parent()
		old_parent.remove_child(child)
		new_parent.add_child(child)
	else:
		print_debug("Global.gd: Attempt to reparent child node failed due to child being null.")
		
func pause_game(pause: bool):
	get_tree().paused = pause
	

func _deferred_goto_scene(path):
	
	current_scene.free()
	
	#print_debug("Loading level...", path)
	var s = load(path)
	
	current_scene = s.instance()
	
	get_tree().get_root().add_child(current_scene)
	
	get_tree().set_current_scene(current_scene)

