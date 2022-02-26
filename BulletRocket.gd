extends Node2D

var velocity = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if(position.y < - 600):
		position.y = 800
	position += Vector2.UP*velocity*delta
func on_collision(area):
	queue_free()
