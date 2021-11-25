extends CanvasLayer

onready var game_manager = get_node("/root/GameManager")

func _on_PlayButton_pressed():
	game_manager.game_running = true
	get_tree().change_scene("res://Scenes/Main.tscn")
