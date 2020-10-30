extends Node2D

const Enemy = preload("Enemy.gd")
const Wall = preload("Wall.gd")

var SPEED = 500
var velocity:Vector2 = Vector2.ZERO # unit vector
var bullet_time:float = 0.0

func _ready():
	self.add_to_group("bullet time")

func _process(_delta):
	if bullet_time > 0:
		self.position += (velocity.normalized() * bullet_time * SPEED)
		bullet_time = 0

func _on_Node2D_body_entered(body):
	if body is Wall or body is Enemy:
		body.queue_free()
		self.queue_free()
