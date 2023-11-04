extends Node2D

var rot_count = 0
var rot_time = 0.1

@onready var p = get_node("../CharacterBody2D")
@onready var player_sprite = get_node("../CharacterBody2D/AnimatedSprite2D")

var flame_speed = Vector2(200.0, 0.0)

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _2d_sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite.play('flame')
	if player_sprite.flip_h == true:
		flame_speed *= -1
		_animated_sprite.flip_h = true
		_animated_sprite.offset.x *= -1
		_2d_sprite.flip_h = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	self.translate(flame_speed * delta)
	
	rot_count += delta
	if rot_count > rot_time:
		_2d_sprite.rotate(PI / 2)
		rot_count = 0
