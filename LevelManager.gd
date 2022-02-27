extends Node2D

export (Array, PackedScene) var levels

onready var current_level = null
onready var exit_tween = $exit_tween
onready var background_tween = $background_tween
onready var enter_tween = $enter_tweeen

var level_number = 0
var past_trails = []

func _ready():
	call_deferred("change_level", level_number)

func level_finished(trail):
	yield(get_tree().create_timer(1.0), "timeout")
	var finished_level = current_level
	
	exit_tween.interpolate_property(current_level, "position:x",
		current_level.position.x, -1000.0, 2.0, Tween.TRANS_CUBIC)
	exit_tween.start()
	
	var old_offset = $ParallaxLayer.scroll_base_offset.x
	background_tween.interpolate_property($ParallaxLayer, "scroll_base_offset:x",
		old_offset, old_offset - 500.0, 2.0, Tween.TRANS_CUBIC)
	background_tween.start()
	
	level_number += 1
	call_deferred("change_level", level_number)
	yield(exit_tween, "tween_completed")
	
	print(trail)
	trail.get_parent().remove_child(trail)
	past_trails.append(trail)
	finished_level.queue_free()

func change_level(index):
	var new_level = levels[index].instance()
	add_child(new_level)
	new_level.global_position = Vector2(1000.0, 0.0)
	
	enter_tween.interpolate_property(new_level, "position:x",
		1000.0, 0.0, 2.0, Tween.TRANS_CUBIC)
	enter_tween.start()
	
	current_level = new_level
	current_level.connect("level_finished", self, "level_finished")
	
	if index == 17:
		print("co kurwa")
		current_level.create_mashups(past_trails)
