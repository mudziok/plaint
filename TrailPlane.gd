extends ViewportContainer

var trail_scene = preload("res://Trail.tscn")

onready var viewport = $Viewport

func create_new_line(start: Vector2):
	var new_trail = trail_scene.instance()
	viewport.add_child(new_trail)
	new_trail.position = Vector2(0, 0)
	return new_trail
