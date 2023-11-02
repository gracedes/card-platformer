extends Node2D

@onready var _animated_sprite = $outline
@onready var _2d_sprite = $icon
@onready var p = get_node("../../CharacterBody2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_num()

func check_num():
	if p.num_wave >= 3:
		_animated_sprite.play("three")
		_2d_sprite.show()
	elif p.num_wave == 2:
		_animated_sprite.play("two")
		_2d_sprite.show()
	elif p.num_wave == 1:
		_animated_sprite.play("one")
		_2d_sprite.show()
	else:
		_animated_sprite.play("zero")
		_2d_sprite.hide()
