extends Camera2D

export (NodePath) onready var player = get_node(player)
var basis = Vector2(512, 300)
var following = Vector2(0, 0)

func _process(delta):
	var target = (player.global_position - basis) / 10.0
	if player.is_paused:
		target = Vector2(0, 0)
	
	following = lerp(following, target, 0.1)
	global_position = following + basis
