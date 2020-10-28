extends Node

func fire(bullets:Array) -> Array:
	for bullet in bullets:
		bullet.scale *= 2
	
	return bullets
