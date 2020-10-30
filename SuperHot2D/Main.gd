extends Node2D

func _process(_delta) -> void:
	var groupies = get_tree().get_nodes_in_group("bullet time")
	print("Bullet timers: %s" % len(groupies))
