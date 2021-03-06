extends Node2D

export (NodePath) onready var player = get_node(player)

var velocity = 300
var rotate_speed = 1
var target_direction = 0

export (bool) var is_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if is_paused:
		return
	
	var distance = position.distance_to(player.position)
	
	
	var target_vector = Vector2(player.position.x - position.x,player.position.y - position.y)
	target_direction = target_vector.angle()+PI/2
	
	if distance <= 100:
		rotation = lerp_angle(rotation, target_direction+PI, 0.2)
		position += Vector2.UP.rotated(rotation)*velocity*delta* min((100-distance)/20, 1)
	else:
		rotation = lerp_angle(rotation, target_direction, 0.05)
		position += Vector2.UP.rotated(rotation)*min(velocity*delta*max(distance/200, 0.1), 375*delta)

func on_collision(area):
	queue_free()

func _on_Level_level_starts():
	is_paused = false
