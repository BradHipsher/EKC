extends Area2D

var buff = 0.1
var tarPos

func _ready():
	tarPos = position

func _unhandled_key_input(event):
	if event.is_action_pressed("Left"):
		moveTween(-64,0)
	if event.is_action_pressed("Right"):
		moveTween(64,0)
	if event.is_action_pressed("Up"):
		moveTween(0,-64)
	if event.is_action_pressed("Down"):
		moveTween(0,64)

func moveTween(dx, dy):
	var tween = Tween.new()
	var newPos = tarPos + Vector2(dx, dy)
	var noCollide = true
	for w in get_tree().get_nodes_in_group("obstruct"):
		if w.position == newPos:
			noCollide = false
	if noCollide:
		tarPos = newPos
		tween.interpolate_property(self, "position", position, tarPos, buff)
		add_child(tween)
		tween.start()
		yield(get_tree().create_timer(buff*2), "timeout")
		tween.queue_free()
