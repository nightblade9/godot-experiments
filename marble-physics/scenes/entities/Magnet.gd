extends Area2D

var _targets = []
const _TRACTION_POWER:int = 100

func _on_Magnet_body_entered(body):
	if not body is StaticBody2D:
		_targets.append(body)

func _on_Magnet_body_exited(body):
	if body in _targets:
		_targets.erase(body)

func _physics_process(delta):
	for target in _targets:
		var vector = (self.position - target.position).normalized()
		target.position += (vector * _TRACTION_POWER * delta)
