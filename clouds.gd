extends ParallaxLayer

export (float) var scroll_speed = 0.25

func _process(delta):
	motion_offset.x += delta * scroll_speed
