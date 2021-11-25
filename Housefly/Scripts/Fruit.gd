extends Area2D

onready var game_manager = get_node("/root/GameManager")
onready var background = get_node("/root/Main/ParallaxBackground")
var scrolling_speed = 200

func _process(delta):
	if game_manager.game_running:
		# Get the fruit's scrolling speed by checking ParlaxxBackground's speed and dividing by 5
		scrolling_speed = background.scrolling_speed / 5
		position.x -= delta * scrolling_speed
