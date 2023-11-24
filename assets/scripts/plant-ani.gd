extends AnimatedSprite2D
var time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	frame = 0
	play('default')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time <= 0.4:
		time += delta
	else:
		queue_free()
