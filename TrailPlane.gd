extends ViewportContainer

var trail_scene = preload("res://Trail.tscn")

onready var viewport = $Viewport

var last_trail = null

func new_trail():
	var new_trail = trail_scene.instance()
	viewport.add_child(new_trail)
	new_trail.position = Vector2(0, 0)
	
	last_trail = new_trail

func new_trail_point(point: Vector2):
	if last_trail != null:
		last_trail.add_point(point / 4 + Vector2(25,25))
