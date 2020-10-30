extends Node2D

const Wall = preload("Wall.gd")

var SPEED = 500
var velocity:Vector2 = Vector2.ZERO # unit vector

func _process(delta):
	self.position += (velocity.normalized() * delta * SPEED)

func _on_Node2D_body_entered(body):
	if body is Wall:
		body.queue_free()
		self.queue_free()
