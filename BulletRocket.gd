extends Node2D

var velocity = 300

func _process(delta):
	if(position.y < - 600):
		position.y = 800
	position += Vector2.UP*velocity*delta
	
func on_collision(area):
	queue_free()
