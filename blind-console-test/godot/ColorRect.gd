extends Node2D

const ROTATION_SPEED = 0.5

func _process(delta):
	self.rotation += delta * ROTATION_SPEED
