extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _collision_shape = $CollisionShape2D

@export var SPEED = 150.0
@export var JUMP_VELOCITY = -300.0

@export var WAVE_VELOCITY = 1875.0
@export var PLANT_VELOCITY = -600.0

var t = Transform2D(0.0, Vector2(1.735, 1.45), 0.0, Vector2(4.205, -0.16))
var flipx = Transform2D(0.0, Vector2(1.735, 1.45), 0.0, Vector2(-4.205, -0.16))

var num_wave = 100000000000
var num_plant = 1000000

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	core_movement(delta)
	check_abilities(delta)

func core_movement(delta):
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
		velocity.x = move_toward(velocity.x, direction * SPEED, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func check_abilities(delta):
	if Input.is_action_just_pressed("ability2") and num_wave > 0:
		wave_ability(delta)
	if Input.is_action_just_pressed("ability3") and num_plant > 0:
		plant_ability(delta)

func wave_ability(delta):
	num_wave -= 1
	if _animated_sprite.flip_h == true:
		velocity.x -= WAVE_VELOCITY
	else:
		velocity.x += WAVE_VELOCITY

func plant_ability(delta):
	num_plant -= 1
	velocity.y = PLANT_VELOCITY

func _process(_delta):
	animation()

func animation():
	if not is_on_floor():
		if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
			_animated_sprite.flip_h = true
			_collision_shape.transform = flipx
		elif Input.is_action_pressed("right"):
			_animated_sprite.flip_h = false
			_collision_shape.transform = t
		_animated_sprite.play("jump")
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		_animated_sprite.flip_h = false
		_collision_shape.transform = t
		_animated_sprite.play("run")
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		_animated_sprite.flip_h = true
		_collision_shape.transform = flipx
		_animated_sprite.play("run")
	else:
		_animated_sprite.play("neutral")
