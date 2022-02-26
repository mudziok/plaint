extends Line2D

signal completed(guide)

var remaining_points = []
var threshold = 50.0
var completed = false

func _ready():
	remaining_points = points

func fill(smokePoint: Vector2):
	var new_remaining_points = []
	
	for point in remaining_points:
		if smokePoint.distance_to(point + global_position) > threshold:
			new_remaining_points.append(point)
	
	remaining_points = new_remaining_points
	
	if remaining_points.size() == 0:
		finished()

func finished():
	if completed == false:
		completed = true
	else:
		return
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self, "modulate:a", modulate.a, 0.0, 0.5, Tween.TRANS_CUBIC)
	tween.start()
	
	yield(tween, "tween_completed")
	emit_signal("completed", self)
	queue_free()
