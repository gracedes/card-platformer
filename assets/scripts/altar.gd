extends Node2D

@onready var _area = $Area2D
@onready var _ani = $AnimatedSprite2D
@onready var burning = false
@onready var startupDone = false
@onready var p = get_node("../CharacterBody2D")
@onready var softlockTimer = 0.0
@onready var timeSinceIgnite = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	_ani.frame = 0
	_ani.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not burning:
		var fbs = get_tree().get_nodes_in_group("fireballs")
		for fb in fbs:
			if _area.overlaps_area(fb):
				burning = true
				_ani.frame = 0
				_ani.play("burn1")
	elif  not startupDone and _ani.frame == 6:
		startupDone = true
		_ani.frame = 0
		_ani.play("burn2")
	if not startupDone and p.num_fire == 0:
		softlockTimer += delta
	if softlockTimer > 3.0:
		p.num_fire += 1
		softlockTimer = 0.0
	if startupDone:
		timeSinceIgnite += 1
