extends Area2D

var buff = 0.1
var tarPos
var roomParent

func _ready():
	tarPos = position
	roomParent = get_parent()

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
	
	# Check if collide first
	for w in get_tree().get_nodes_in_group("obstruct"):
		if w.position == newPos:
			return
	
	# Check if room change next
	if newPos.x < 0:
		nextRoom("Left")
		return
	if newPos.x > 1216:
		nextRoom("Right")
		return
	if newPos.y < 0:
		nextRoom("Up")
		return
	if newPos.y > 832:
		nextRoom("Down")
		return
	
	tarPos = newPos
	tween.interpolate_property(self, "position", position, tarPos, buff)
	add_child(tween)
	tween.start()
	yield(get_tree().create_timer(buff*2), "timeout")
	tween.queue_free()

func nextRoom(dir):
	print(dir)
	roomParent.get_parent().nextRoom(dir)
