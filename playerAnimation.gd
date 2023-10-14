extends AnimatedSprite2D

@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left") != Input.is_action_pressed("right"):
		_animated_sprite.play("run")
	else:
		_animated_sprite.play("neutral")
