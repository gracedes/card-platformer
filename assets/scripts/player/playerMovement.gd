extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

@export var SPEED = 150.0
@export var JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _process(_delta):
	if not is_on_floor():
		if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
			_animated_sprite.flip_h = true
		elif Input.is_action_pressed("right"):
			_animated_sprite.flip_h = false
		_animated_sprite.play("jump")
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		_animated_sprite.flip_h = false
		_animated_sprite.play("run")
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		_animated_sprite.flip_h = true
		_animated_sprite.play("run")
	else:
		_animated_sprite.play("neutral")
