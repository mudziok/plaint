extends AudioStreamPlayer

onready var tween = $SoundTween

func start():
	tween.interpolate_property(self, "volume_db", volume_db, -36, 1.0, Tween.TRANS_CUBIC)
	tween.start()

func stop():
	tween.interpolate_property(self, "volume_db", volume_db, -80, 1.0, Tween.TRANS_CUBIC)
	tween.start()
