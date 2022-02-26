extends Sprite

onready var tween = $SquishTween
export (float) onready var squish_time = 0.05

func squish():
	tween.interpolate_property(self, "scale:y", scale.y, 3.5, squish_time, Tween.TRANS_CUBIC)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property(self, "scale:y", scale.y, 4.0, squish_time * 8, Tween.TRANS_CUBIC)
	tween.start()
