extends Node2D
@onready var p = get_node("../CharacterBody2D")
@export var x_speed = 30.0
@export var y_speed = 25.0
@export var x_buffer = 1.0
@export var y_buffer = 0.3
@export var give = 100.0
@export var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var goal_pos = p.position + (p.velocity * Vector2(x_buffer, y_buffer))
	# drift_to(goal_pos)
	
	if goal_pos.x < p.position.x - give:
		goal_pos.x = p.position.x - give
	elif goal_pos.x > p.position.x + give:
		goal_pos.x = p.position.x + give
	if goal_pos.y < p.position.y - give:
		goal_pos.y = p.position.y - give
	elif goal_pos.y > p.position.y + give:
		goal_pos.y = p.position.y + give
		
	self.position = goal_pos
	
func drift_to(pos):
	if self.position.x < pos.x - give:
		self.position.x += x_speed
	elif self.position.x > pos.x + give:
		self.position.x -= x_speed
	# else:
		# self.position = pos
	if self.position.y < pos.y - give:
		self.position.y += y_speed
	elif self.position.y > pos.y + give:
		self.position.y -= y_speed
