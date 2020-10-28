extends Node

func fire(bullets:Array) -> Array:
	var copies = []
	
	for bullet in bullets:
		copies.append(bullet)

		var b1 = bullet.duplicate()
		b1.velocity.x += randi() % 10
		b1.velocity.y += randi() % 5
		copies.append(b1)

		var b2 = bullet.duplicate()
		b2.velocity.x += randi() % 10
		b2.velocity.y -= randi() % 5
		copies.append(b2)
	
	return copies
