extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _collision_shape = $CollisionShape2D
@onready var root = get_node("..")

@export var SPEED = 150.0
@export var JUMP_VELOCITY = -300.0

@export var WAVE_VELOCITY = 1875.0
@export var PLANT_VELOCITY = -600.0
@onready var cloud_prefab = preload("res://assets/prefabs/cloud.tscn")
@onready var fire_prefab = preload("res://assets/prefabs/fireball.tscn")
var mid_sling = false
@export var sling_time = 2.0
var sling_count = 0.0
var sling_coefficient = 400
var post_sling = -1
var post_sling_coefficient = 0.15

var t = Transform2D(0.0, Vector2(1.735, 1.45), 0.0, Vector2(4.205, -0.16))
var flipx = Transform2D(0.0, Vector2(1.735, 1.45), 0.0, Vector2(-4.205, -0.16))

var num_cloud = 3
var num_wave = 3
var num_plant = 3
var num_fire = 1000000000000000
var num_sling = 3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	core_movement(delta)
	check_abilities(delta)

func core_movement(delta):
	# Add the gravity.
	if not is_on_floor() and not mid_sling:
		velocity.y += gravity * delta
	elif mid_sling:
		velocity.y = 0

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not mid_sling:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction and not mid_sling and post_sling <= 0.0:
		velocity.x = move_toward(velocity.x, direction * SPEED, SPEED)
	elif post_sling <= 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	post_sling -= delta

func check_abilities(delta):
	if Input.is_action_just_pressed("ability1") and num_cloud > 0 and not mid_sling:
		cloud_ability(delta)
	if Input.is_action_just_pressed("ability2") and num_wave > 0 and not mid_sling:
		wave_ability(delta)
	if Input.is_action_just_pressed("ability3") and num_plant > 0 and not mid_sling:
		plant_ability(delta)
	if Input.is_action_just_pressed("ability4") and num_fire > 0 and not mid_sling:
		fire_ability(delta)
	if mid_sling or (Input.is_action_just_pressed("ability5") and num_sling > 0):
		sling_ability(delta)

func cloud_ability(delta):
	num_cloud -= 1
	var cloud_obj = cloud_prefab.instantiate()
	
	cloud_obj.position.x = self.position.x
	
	if _animated_sprite.flip_h == true:
		cloud_obj.position.x -= 3
	else:
		cloud_obj.position.x += 3
	
	cloud_obj.position.y = self.position.y + 30
	
	root.add_child((cloud_obj))

func wave_ability(delta):
	num_wave -= 1
	if _animated_sprite.flip_h == true:
		velocity.x -= WAVE_VELOCITY
	else:
		velocity.x += WAVE_VELOCITY

func plant_ability(delta):
	num_plant -= 1
	velocity.y = PLANT_VELOCITY
	
func fire_ability(delta):
	num_fire -= 1
	var fire_obj = fire_prefab.instantiate()
	
	fire_obj.position.x = self.position.x
	
	if _animated_sprite.flip_h == true:
		fire_obj.position.x -= 20
	else:
		fire_obj.position.x += 20
	
	fire_obj.position.y = self.position.y
	
	root.add_child((fire_obj))
	
func sling_ability(delta):
	if not mid_sling:
		mid_sling = true
		sling_count = 0.0
		num_sling -= 1
	elif mid_sling and sling_count < sling_time:
		sling_count += delta
	elif sling_count >= sling_time:
		mid_sling = false
		sling_count = 0.0
		var vector = Vector2(0, 0)
		if Input.is_action_pressed("left"):
			vector += Vector2(-1, 0)
		elif Input.is_action_pressed("right"):
			vector += Vector2(1, 0)
		if Input.is_action_pressed("up"):
			vector += Vector2(0, -1)
		elif Input.is_action_pressed("down"):
			vector += Vector2(0, 1)
		vector *= sling_coefficient
		velocity = vector
		post_sling = post_sling_coefficient
		print(vector)

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
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left") and not mid_sling:
		_animated_sprite.flip_h = false
		_collision_shape.transform = t
		_animated_sprite.play("run")
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right") and not mid_sling:
		_animated_sprite.flip_h = true
		_collision_shape.transform = flipx
		_animated_sprite.play("run")
	elif not mid_sling:
		_animated_sprite.play("neutral")
	else:
		_animated_sprite.stop()
