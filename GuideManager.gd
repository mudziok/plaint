extends Node2D

signal all_guides_completed

var remaining_guides = []

func _ready():
	remaining_guides = get_children()

func _on_guide_completed(completed_guide):
	var new_reamaining_guides = []
	for guide in remaining_guides:
		if guide != completed_guide:
			new_reamaining_guides.append(guide)
	
	remaining_guides = new_reamaining_guides
	
	if remaining_guides.size() == 0:
		emit_signal("all_guides_completed")
