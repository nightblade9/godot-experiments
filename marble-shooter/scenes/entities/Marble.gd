extends KinematicBody2D

signal on_clicked
signal done_moving

const _IMPULSE:int = 500
const _STOP_VELOCITY:int = 10
const _FRICTION:float = 0.99

var _velocity:Vector2 = Vector2.ZERO

func fire_at(target:KinematicBody2D) -> void:
	var direction = (target.position - self.position).normalized()
	_velocity = direction * _IMPULSE
	
func _physics_process(delta):
	if _velocity.length() > _STOP_VELOCITY:
		self.move_and_collide(_velocity * delta)
		_velocity *= _FRICTION
	else:
		_velocity = Vector2.ZERO
		emit_signal("done_moving", self)
		
func _on_SelectionArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var button = event as InputEventMouseButton
		if button.pressed:
			emit_signal("on_clicked", self)
