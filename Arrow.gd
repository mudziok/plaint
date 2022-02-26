extends Sprite

signal finished_blinking

var blink_time = 0.3
var iterations = 4

func blink():
	for i in range(iterations):
		yield(get_tree().create_timer(blink_time), "timeout")
		modulate.a = 1.0
		yield(get_tree().create_timer(blink_time), "timeout")
		modulate.a = 0.0
	emit_signal("finished_blinking")
