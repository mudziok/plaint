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
	$trails/heart.position = 1000
	
	$trails/tictac.add_child(trails[3])
	$trails/tictac.add_child(trails[9])
	$trails/tictac.add_child(trails[15])
	$trails/tictac.position = 2000
	
	$trails/mudkip.add_child(trails[3])
	$trails/mudkip.add_child(trails[9])
	$trails/mudkip.add_child(trails[15])
	$trails/mudkip.position = 3000
