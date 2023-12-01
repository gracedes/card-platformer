extends Node2D

@onready var background = $AnimatedSprite2D2
@onready var letters = $AnimatedSprite2D
@export var next = "res://scenes/test.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var mousePos = get_viewport().get_mouse_position()
	if (mousePos.x >= 256.0 and mousePos.x <= 373.0) and (mousePos.y >= 420.0 and mousePos.y <= 468.0):
		background.play("hover")
		letters.play("hover")
		checkClick()
	else:
		background.play("default")
		letters.play("default")

func checkClick():
	if Input.is_action_just_pressed("left-click"):
		get_tree().change_scene_to_file(next)
