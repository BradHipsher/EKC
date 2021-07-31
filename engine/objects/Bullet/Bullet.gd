extends Area2D

var startTime
var dir
var startPos
var roomParent

const pxpb:float = 64.0 * 2.0 #px/beat

func _ready():
	roomParent = get_parent().get_parent()
	startPos = position

func _process(delta):
	position.x += dir.x
	position.y += dir.y
	if position.x > 1216 + 64:
		queue_free()
	if position.x < 0 - 64:
		queue_free()
	if position.y > 832 + 64:
		queue_free()
	if position.y < 0 - 64:
		queue_free()


func _on_Bullet_area_entered(area):
	for a in get_tree().get_nodes_in_group("wall"):
		if area == a:
			queue_free()
	for a in get_tree().get_nodes_in_group("player"):
		if area == a:
			queue_free()

func tick(beat, time):
	var bpms = 1.0 / Global.mspb
	position.x = startPos.x + (dir.x * pxpb *  bpms * 1000.0 * (time - startTime))
	position.y = startPos.y + (dir.y * pxpb *  bpms * 1000.0 * (time - startTime))
