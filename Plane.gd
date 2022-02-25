extends Node2D

var rotate_speed = 3

var acceleration = 300
var drag = 100
var velocity = 300 
var min_velocity = 300
var max_velocity = 550

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(200,200) #do wywalenia po testach
	pass # Replace with function body.

func _process(delta):
	
	position += Vector2.UP.rotated(rotation)*velocity*delta
	
	velocity = max(velocity-drag*delta, min_velocity)
	
	if Input.is_action_pressed("accelerate"):
		velocity = min(velocity+acceleration*delta, max_velocity)
	
	
	if Input.is_action_pressed("left"):
		rotation -= rotate_speed*delta
	if Input.is_action_pressed("right"):
		rotation += rotate_speed*delta
	
