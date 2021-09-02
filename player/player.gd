extends KinematicBody2D

export var walk_speed = 4
const TILE_SIZE = 8

var initial_position = Vector2(0,0)
var input_direction = Vector2(0,0)

var is_moving = false
var percent_moved_to_next_tile = 0.0

var coins_collected = 0
var chests = []
var enemies = []
var level_tilemap

onready var anim_player = $AnimationPlayer
onready var ray = $RayCast2D

signal bumped_chest(id,dir)
signal turn_over()
signal moved()
signal hit_enemy(id,dir)
signal bumped_npc


func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()

	chests = tree.get_nodes_in_group("Chest")
	
	for x in chests:
		x.connect("coin_awarded", self, "increase_coin_collected_count")
		x.connect("blocked", self, "stop_moving")
	
	enemies = tree.get_nodes_in_group("Enemy")
	for x in enemies:
		x.connect("hit_player", self, "enemy_hit_me")
	
	initial_position = position
	anim_player.play("static")
	
	level_tilemap = tree.current_scene.get_node("TileMap")
	print(level_tilemap.turns_left)
	

func _physics_process(delta):
	if is_moving == false:
		process_player_input()
	elif input_direction != Vector2.ZERO:
		move(delta)
	else:
		is_moving = false


func process_player_input():	
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	if input_direction != Vector2.ZERO:
		initial_position = position
		is_moving = true
	
	if Input.is_action_pressed("ui_right"):
		get_node( "Sprite" ).set_flip_h( false )
		anim_player.play("move")
	elif Input.is_action_pressed("ui_left"):
		get_node( "Sprite" ).set_flip_h( true )
		anim_player.play("move")
		
	# elif Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up):
		# anim_player.play("move")
	else:
		pass
		#anim_player.play("static")
	


func move(delta):	
	var desired_step: Vector2 = input_direction * TILE_SIZE / 2
	
	ray.cast_to = desired_step
	ray.force_raycast_update()
	if !ray.is_colliding(): # Check for collision before moving		
		percent_moved_to_next_tile += walk_speed * delta
		if percent_moved_to_next_tile >= 1.0:
			# anim_player.play("move")
			position = initial_position + (TILE_SIZE * input_direction)
			percent_moved_to_next_tile = 0.0
			is_moving = false
			emit_signal("moved")
			$AnimationPlayer2.play("idle")
			
			Global.turns_left -= 1
			if level_tilemap.turns_left > 0:
				level_tilemap.turns_left -= 1
			else:
				level_tilemap.turns_left = 1
				emit_signal("turn_over")
							
			
		else:
			position = initial_position + (TILE_SIZE * input_direction * percent_moved_to_next_tile)
			
	#elif ray.get_collider().is_in_group("Collidable") or ray.get_collider().get_node("Collidable"):
		#is_moving = false
		
	else:		
		if ray.get_collider().is_in_group("Chest"):
			emit_signal("bumped_chest",ray.get_collider().name, input_direction)
		elif ray.get_collider().is_in_group("Enemy"):
			get_parent().get_node("ShakeCamera").add_shake()
			emit_signal("hit_enemy",ray.get_collider().name, input_direction)
		elif ray.get_collider().is_in_group("NPC"):
			emit_signal("bumped_npc")
			is_moving = false
		else:
			is_moving = false
		
func stop_moving():
	is_moving = false

func increase_coin_collected_count():
	coins_collected += 1
	print(coins_collected)

func enemy_hit_me(dir):
	anim_player.play("hit")
	input_direction = dir
	initial_position = position
	is_moving = true
	level_tilemap.turns_left += 1
	coins_collected = 0


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "idle":
		anim_player.play("move")
	if anim_name == "move":
		anim_player.play("static")
	pass # Replace with function body.
