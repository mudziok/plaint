extends Node2D

onready var current_level = $Level
onready var exit_tween = $exit_tween
onready var background_tween = $background_tween

func _ready():
	current_level.connect("level_finished", self, "level_finished")

func level_finished():
	yield(get_tree().create_timer(1.0), "timeout")
	
	exit_tween.interpolate_property(current_level, "position:x",
		current_level.position.x, -1000.0, 2.0, Tween.TRANS_CUBIC)
	exit_tween.start()
	
	var old_offset = $ParallaxLayer.scroll_base_offset.x
	background_tween.interpolate_property($ParallaxLayer, "scroll_base_offset:x",
		old_offset, old_offset - 500.0, 2.0, Tween.TRANS_CUBIC)
	background_tween.start()
	
	yield(exit_tween, "tween_completed")
	print("gites")
