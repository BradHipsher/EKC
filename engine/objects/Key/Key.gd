extends Area2D

func _on_Key_area_entered(area):
	for a in get_tree().get_nodes_in_group("player"):
		if area == a:
			queue_free()
