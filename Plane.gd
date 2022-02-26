extends Node2D

signal new_smoke(point)

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

export (NodePath) onready var trailPane = get_node(trailPane)
var last_trail = null

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(-50,300) #do wywalenia po testach
	rotate(PI/2)

func _process(delta):
	position += Vector2.UP.rotated(rotation)*velocity*delta
	if position.x < -100:
		position.x = 1150
		last_trail = trailPane.create_new_line(position)
	elif position.x > 1150:
		position.x = -100
		last_trail = trailPane.create_new_line(position)
	
	velocity = max(velocity - drag*delta, min_velocity)
	
	if Input.is_action_pressed("accelerate") and fuel_left > 0:
		velocity = min(velocity + acceleration*delta, max_velocity)
		fuel_left -= fuel_usage*delta
		if last_trail != null:
			last_trail.add_point(position / 4 + Vector2(25,25))
			emit_signal("new_smoke", position)
	else:
		fuel_left = min(fuel_left+fuel_restore*delta, 100)
	
	if Input.is_action_pressed("left"):
		rotation -= rotate_speed*delta*velocity*0.003
	if Input.is_action_pressed("right"):
		rotation += rotate_speed*delta*velocity*0.003
	
	if Input.is_action_just_pressed("accelerate") :
		last_trail = trailPane.create_new_line(position)
		var tween_time = 0.05
		
		
		var tween = Tween.new()
		add_child(tween)
		tween.interpolate_property($Sprite, "scale:y", $Sprite.scale.y, 3.5, tween_time, Tween.TRANS_CUBIC)
		tween.start()
		yield(tween, "tween_completed")
		tween.interpolate_property($Sprite, "scale:y", $Sprite.scale.y, 4.0, tween_time * 8, Tween.TRANS_CUBIC)
		tween.start()
	
	if Input.is_action_just_released("accelerate"):
		last_trail = null


func on_collision(area):
	emit_signal("destroyed")
	pass # Replace with function body.
