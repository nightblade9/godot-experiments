extends RigidBody2D

signal on_clicked

const _IMPULSE:int = 300
const _STOP_VELOCITY:int = 10
const _DECAY:float = 0.01

func fire_at(target:Node2D) -> void:
	var direction = (target.position - self.position).normalized()
	var impulse = direction * _IMPULSE
	apply_impulse(Vector2.ZERO, impulse)
	
func _on_SelectionArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var button = event as InputEventMouseButton
		if button.pressed:
			emit_signal("on_clicked", self)
