extends Node2D

var rotate_speed = 3

var acceleration = 4000
var drag = 1000
var velocity = 300 
var min_velocity = 250
var max_velocity = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(200,200) #do wywalenia po testach

func _process(delta):
	
	position += Vector2.UP.rotated(rotation)*velocity*delta
	
	velocity = max(velocity - drag*delta, min_velocity)
	
	if Input.is_action_pressed("accelerate"):
		velocity = min(velocity + acceleration*delta, max_velocity)
	
	
	if Input.is_action_pressed("left"):
		rotation -= rotate_speed*delta*velocity*0.003
	if Input.is_action_pressed("right"):
		rotation += rotate_speed*delta*velocity*0.003
	
	if Input.is_action_just_pressed("accelerate"):
		var tween_time = 0.05
		var tween = Tween.new()
		add_child(tween)
		tween.interpolate_property($Sprite, "scale:y", $Sprite.scale.y, 3.5, tween_time, Tween.TRANS_CUBIC)
		tween.start()
		yield(tween, "tween_completed")
		tween.interpolate_property($Sprite, "scale:y", $Sprite.scale.y, 4.0, tween_time * 8, Tween.TRANS_CUBIC)
		tween.start()
