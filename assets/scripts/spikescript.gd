extends StaticBody2D
@onready var p = get_node("../../CharacterBody2D")
@onready var _area = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _area.overlaps_body(p):
		get_tree().reload_current_scene()
