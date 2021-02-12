extends Node2D

# Cycles along 0..2pi
var cyclic_time:float = 0

func _process(delta):
	self.cyclic_time += delta
	if self.cyclic_time >= 2 * PI:
		self.cyclic_time -= 2 * PI
