extends Node2D

export (Array, PackedScene) var levels

onready var current_level = null
onready var exit_tween = $exit_tween
onready var background_tween = $background_tween
onready var enter_tween = $enter_tweeen

func _ready():
	call_deferred("change_level", 0)

func level_finished():
	yield(get_tree().create_timer(1.0), "timeout")
	
	exit_tween.interpolate_property(current_level, "position:x",
		current_level.position.x, -1000.0, 2.0, Tween.TRANS_CUBIC)
	exit_tween.start()
	
	var old_offset = $ParallaxLayer.scroll_base_offset.x
	background_tween.interpolate_property($ParallaxLayer, "scroll_base_offset:x",
		old_offset, old_offset - 500.0, 2.0, Tween.TRANS_CUBIC)
	background_tween.start()
	
	call_deferred("change_level", 1)
	yield(exit_tween, "tween_completed")
	print("gites")

func change_level(index):
	var new_level = levels[index].instance()
	add_child(new_level)
	new_level.global_position = Vector2(1000.0, 0.0)
	
	enter_tween.interpolate_property(new_level, "position:x",
		1000.0, 0.0, 2.0, Tween.TRANS_CUBIC)
	enter_tween.start()
	
	current_level = new_level
	current_level.connect("level_finished", self, "level_finished")
