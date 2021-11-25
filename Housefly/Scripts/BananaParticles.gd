extends CPUParticles2D

var counter = 0

func _ready():
	emitting = true
	
func _process(delta):
	counter += delta
	if counter > 3:
		queue_free()
