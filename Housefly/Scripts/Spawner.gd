extends Node

var fruit_scene = load("res://Scenes/Fruit.tscn")
var stal_scene = load("res://Scenes/Stalactite.tscn")
var warning_scene = load("res://Scenes/Warning.tscn")

onready var fly = get_parent().get_node("Fly")
onready var game_manager = get_node("/root/GameManager")

var fruit_counter = 0
var stal_counter = 0
var fruit_delay = 3
var stal_delay = 5


func _process(delta):
	if not game_manager.game_running:
		return 
		
	# Increment counter by 1 each second
	fruit_counter += delta
	stal_counter += delta
	# If the counter is larger than the associated spawn delay, then spawn a new item
	if fruit_counter > fruit_delay:
		spawn_fruit()
		# Decrease the fruit delay if it isn't too low already
		if fruit_delay > 1.5:
			fruit_delay -= 0.1
	if stal_counter > stal_delay:
		spawn_stalactite()
		# Decrease the stal delay if it isn't too low already
		if stal_delay > 2:
			stal_delay -= 0.1

func spawn_fruit():
	fruit_counter = 0
	var fruit = fruit_scene.instance()
	fruit.position = Vector2(1250 + rand_range(0, 500), rand_range(150, 450))
	add_child(fruit)

func spawn_stalactite():
	stal_counter = 0
	# Spawn the warning right near the player
	var warning = warning_scene.instance()
	var saved_pos = fly.position.x + rand_range(160, -160)
	warning.position = Vector2(saved_pos, 340)
	add_child(warning)
	# Wait for a while and then remove the warning
	yield(get_tree().create_timer(1.0), "timeout")
	warning.queue_free()
	# Spawn the stalactite right above where the warning was
	var stal = stal_scene.instance()
	stal.position = Vector2(saved_pos, 0)
	add_child(stal)
	yield(get_tree().create_timer(3.0), "timeout")
	stal.queue_free()
	
