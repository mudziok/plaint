extends Node2D

signal start_smoke
signal new_smoke_point(point)

signal destroyed

var rotate_speed = 4

var acceleration = 4000
var drag = 1000
var velocity = 300 
var min_velocity = 250
var max_velocity = 400

var fuel_left = 100
var fuel_usage = 50
var fuel_restore = 20

func _ready():
	position = Vector2(-50,300) #do wywalenia po testach
	rotate(PI/2)

func fix_out_of_bounds():
	if position.x < -100:
		position.x = 1124
		emit_signal("start_smoke")
	elif position.x > 1124:
		position.x = -100
		emit_signal("start_smoke")

func _process(delta):
	position += Vector2.UP.rotated(rotation)*velocity*delta
	fix_out_of_bounds()
	
	velocity = max(velocity - drag*delta, min_velocity)
	
	if Input.is_action_pressed("left"):
		rotation -= rotate_speed*delta*velocity*0.003
	if Input.is_action_pressed("right"):
		rotation += rotate_speed*delta*velocity*0.003
	
	if Input.is_action_just_pressed("accelerate") :
		emit_signal("start_smoke")
		$PlaneSprite.squish()
	
	if Input.is_action_pressed("accelerate") and fuel_left > 0:
		velocity = min(velocity + acceleration*delta, max_velocity)
		fuel_left -= fuel_usage*delta
		emit_signal("new_smoke_point", position)
	else:
		fuel_left = min(fuel_left+fuel_restore*delta, 100)


func on_collision(area):
	emit_signal("destroyed")
