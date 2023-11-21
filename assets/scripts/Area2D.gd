extends Area2D
@export var next = "res://scenes/screen"
@onready var p = get_node("../CharacterBody2D")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_contact()
	
func check_contact():
	if overlaps_body(p):
		get_tree().change_scene_to_file(next)
