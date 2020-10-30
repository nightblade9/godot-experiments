extends KinematicBody2D

const _VELOCITY = 100
var _target:Node2D # player
var bullet_time:float = 0.0

func _ready():
	self.add_to_group("bullet time")

func initialize(target:Node2D) -> void:
	_target = target

func _process(_delta):
	if bullet_time > 0:
		var direction = (_target.position - self.position).normalized()
		print("%s" % (direction * _VELOCITY))
		self.move_and_slide(direction * _VELOCITY)
		bullet_time = 0
