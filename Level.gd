extends Node2D

class_name Level

signal level_finished

var current_time = 0

func _ready():
	$Plane.visible = false
	$Arrow.visible = false
	yield(get_tree().create_timer(2.0), "timeout")
	$Arrow.visible = true
	$Arrow.blink()
	yield($Arrow, "finished_blinking")
	$Arrow.queue_free()
	$Plane.visible = true
	$Plane.is_paused = false
	$CanvasLayer/FuelGauge.change_hidden(false)

func level_finished():
	$Plane.is_on_autopilot = true
	$CanvasLayer/FuelGauge.change_hidden(true)
	yield($Plane, "exited_top")
	$Plane.is_paused = true
	emit_signal("level_finished")
