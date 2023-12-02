extends Camera2D

@onready var alt = get_node("../Node2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if alt.timeSinceIgnite > 3.0 and position.y > -412.0:
		position.y -= delta * 20.0
