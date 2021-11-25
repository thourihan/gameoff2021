extends AudioStreamPlayer

export var kill_time  : float = 0
var counter = 0

func _process(delta):
	counter += delta
	if counter > kill_time:
		queue_free()
