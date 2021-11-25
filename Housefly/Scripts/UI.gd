extends CanvasLayer

onready var label = $CenterContainer.get_node("Label")
onready var background = get_node("/root/Main/ParallaxBackground")
onready var game_manager = get_node("/root/GameManager")
var dist_traveled = 0

func _process(_delta):
	if game_manager.game_running:
		dist_traveled += background.scrolling_speed / 16000
		label.text = "Distance Traveled: " + str(round(dist_traveled))
