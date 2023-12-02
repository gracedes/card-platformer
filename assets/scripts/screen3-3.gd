extends Node2D

@onready var sprt = get_node("./CharacterBody2D/AnimatedSprite2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	sprt.flip_h = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
