extends Node2D

func _ready():
	for enemy in $Enemies.get_children():
		enemy.initialize($Player)

func _process(_delta) -> void:
	if BulletTime.bullet_time > 0:
		var remaining = BulletTime.bullet_time
		BulletTime.bullet_time -= remaining
		
		var groupies = get_tree().get_nodes_in_group("bullet time")
		for node in groupies:
			node.bullet_time += remaining
