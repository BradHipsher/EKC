extends ColorRect

var pulser
var pulserAnimTrack

func _ready():
	pulser = get_node("pulser")
	rect_size = Vector2(1216,832)

func pulse():
	pulser.play("pulse" + str(Global.key_change))
