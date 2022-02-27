extends Node2D

signal level_starts
signal level_finished(trails)

var current_time = 0

func _ready():
	$Plane.is_paused = false
	emit_signal("level_starts")

func level_finished():
	$Plane.is_on_autopilot = true
	yield($Plane, "exited_top")
	$Plane.is_paused = true
	emit_signal("level_finished", $TrailPlane)

func create_mashups(trails):
	$trails/heart.add_child(trails[5])
	$trails/heart.add_child(trails[7])
	$trails/heart.position.x = 800
	
	$trails/tictac.add_child(trails[3])
	$trails/tictac.add_child(trails[9])
	$trails/tictac.add_child(trails[15])
	$trails/tictac.position.x = 1400
	
	$trails/mudkip.add_child(trails[6])
	$trails/mudkip.add_child(trails[10])
	$trails/mudkip.add_child(trails[13])
	trails[13].rect_position.y -= 260
	$trails/mudkip.position.y += 100
	$trails/mudkip.position.x = 2000
