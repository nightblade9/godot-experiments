extends Node2D

var _target:Node2D # player
var bullet_time:float = 0.0

func _ready():
	self.add_to_group("bullet time")

func initialize(target:Node2D) -> void:
	_target = target
