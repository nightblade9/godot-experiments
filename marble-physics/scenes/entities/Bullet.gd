extends Area2D

const _ROTATION_DEGREES_PER_SECOND:int = 360
const _SPEED:int = 150

var _velocity:Vector2

func fire(direction:Vector2) -> void:
	self._velocity = direction.normalized() * _SPEED
	
func _physics_process(delta):
	self.position += (self._velocity * delta)
	self.rotation_degrees += delta * _ROTATION_DEGREES_PER_SECOND
