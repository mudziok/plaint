extends Node2D

signal start_smoke
signal new_smoke_point(point)
signal exited_top
signal fuel_changed(value)

signal destroyed

var is_on_autopilot = false
export (bool) var is_paused = false
onready var refillTimer = $RefillTimer

var rotate_speed = 4
var can_refill = true

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

func handle_out_of_bounds():
	if position.x < -100:
		position.x = 1124
		emit_signal("start_smoke")
	elif position.x > 1124:
		position.x = -100
		emit_signal("start_smoke")
	if position.y < -100:
		emit_signal("exited_top")

func _process(delta):
	if is_paused:
		return
	
	position += Vector2.UP.rotated(rotation)*velocity*delta
	velocity = max(velocity - drag*delta, min_velocity)
	
	handle_out_of_bounds()
	
	if is_on_autopilot:
		velocity = min(velocity + acceleration*delta, max_velocity)
		rotation = lerp_angle(rotation, 0, 0.05)
		return
	
	if Input.is_action_pressed("left"):
		rotation -= rotate_speed*delta*velocity*0.003
	if Input.is_action_pressed("right"):
		rotation += rotate_speed*delta*velocity*0.003
	
	if Input.is_action_just_pressed("accelerate") :
		emit_signal("start_smoke")
		$PlaneSprite.squish()
	
	if Input.is_action_pressed("accelerate") and fuel_left > 0:
		can_refill = false
		refillTimer.start()
		velocity = min(velocity + acceleration*delta, max_velocity)
		fuel_left -= fuel_usage*delta
		emit_signal("new_smoke_point", position)
	elif can_refill and !Input.is_action_pressed("accelerate"):
		fuel_left = min(fuel_left+fuel_restore*delta, 100)
	
	emit_signal("fuel_changed", fuel_left)


func on_collision(area):
	emit_signal("destroyed")

func _on_RefillTimer_timeout():
	can_refill = true
