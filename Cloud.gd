extends Node2D

var velocity = 50

func _process(delta):
	position += Vector2.LEFT*velocity*delta
	
	if position.x > 1300:
		position.x = -200
	elif position.x < -200:
		position.x = 1300
