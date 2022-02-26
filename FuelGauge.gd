extends Control

onready var bar = $ViewportContainer/Viewport/ProgressBar
onready var tween = $Tween
export (bool) var hidden = false

func _ready():
	if hidden:
		modulate.a = 0.0

func set_value(new_value: float):
	bar.value = new_value

func change_hidden(new_hidden):
	hidden = new_hidden
	var alpha = 1.0 - float(hidden)
	tween.interpolate_property(self, "modulate:a", modulate.a, alpha, 0.5, Tween.TRANS_CUBIC)
	tween.start()
