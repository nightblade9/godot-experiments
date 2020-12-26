extends KinematicBody2D

signal on_clicked
signal done_moving

const _IMPULSE:int = 500
const _STOP_VELOCITY:int = 10
const _DECAY:float = 0.01

var _velocity:Vector2 = Vector2.ZERO

func fire_at(target:KinematicBody2D) -> void:
	var direction = (target.position - self.position).normalized()
	_velocity = direction * _IMPULSE
	
func _physics_process(delta):
	if _velocity.length() > _STOP_VELOCITY:
		# bounce code from: https://docs.godotengine.org/en/3.2/tutorials/physics/using_kinematic_body_2d.html#bouncing-reflecting
		var collision = move_and_collide(_velocity * delta)
		if collision:
			_velocity = _velocity.bounce(collision.normal)
			if collision.collider.has_method("hit"):
				collision.collider.hit()
				
		_velocity *= (1 - _DECAY)
	else:
		_velocity = Vector2.ZERO
		emit_signal("done_moving", self)
		
		
func _on_SelectionArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var button = event as InputEventMouseButton
		if button.pressed:
			emit_signal("on_clicked", self)
