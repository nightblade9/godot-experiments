extends RigidBody2D

signal on_clicked

func _on_SelectionArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var button = event as InputEventMouseButton
		if button.pressed:
			emit_signal("on_clicked", self)
