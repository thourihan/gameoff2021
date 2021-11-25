extends ParallaxBackground

var scrolling_speed = 1000
onready var game_manager = get_node("/root/GameManager")

func _process(delta):
	# Constantly move the background to the left and constantly increase the scrolling speed if the game is running
	if game_manager.game_running:
		scroll_offset.x -= scrolling_speed * delta
		scrolling_speed += delta*4
