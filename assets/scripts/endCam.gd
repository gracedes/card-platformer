extends Camera2D

@onready var alt = get_node("../Node2D")
@export var next = "res://scenes/title.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if alt.timeSinceIgnite > 3.0 and position.y > -412.0:
		position.y -= delta * 20.0
	elif alt.timeSinceIgnite > 3.0:
		if Input.is_action_just_pressed("left-click"):
			get_tree().change_scene_to_file(next)
