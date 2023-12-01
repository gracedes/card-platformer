extends StaticBody2D

@onready var _area = $Area2D
@onready var ani = $AnimatedSprite2D
@onready var burning = false
@export var burn_time = 0.25
@onready var burn_count = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	ani.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not burning:
		var fbs = get_tree().get_nodes_in_group("fireballs")
		for fb in fbs:
			if _area.overlaps_area(fb):
				burning = true
	elif burning and burn_count < burn_time:
		ani.play("burning")
		burn_count += delta
	else:
		queue_free()
	
	var cts = get_tree().get_nodes_in_group("crate")
	for ct in cts:
		if _area.overlaps_area(ct._area) and ct.burn_count >= burn_time / 2:
			burning = true
			
