extends Area2D

var startTime
var dir

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
