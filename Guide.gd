extends Line2D

var remaining_points = []
var threshold = 50.0

func _ready():
	remaining_points = points

func fill(smokePoint: Vector2):
	var new_remaining_points = []
	
	for point in remaining_points:
		if smokePoint.distance_to(point) > threshold:
			new_remaining_points.append(point)
	
	remaining_points = new_remaining_points
	
	print("Pozostalo: ", remaining_points.size())
