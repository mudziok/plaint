extends Node2D

signal all_guides_completed

var remaining_guides = []

func _ready():
	remaining_guides = get_children()
	for guides in remaining_guides:
		guides.connect("completed", self, "_on_guide_completed")

func _on_guide_completed(completed_guide):
	var new_reamaining_guides = []
	for guide in remaining_guides:
		if guide != completed_guide:
			new_reamaining_guides.append(guide)
	
	remaining_guides = new_reamaining_guides
	
	if remaining_guides.size() == 0:
		emit_signal("all_guides_completed")

func new_trail_point(point: Vector2):
	for guide in remaining_guides:
		guide.fill(point)
