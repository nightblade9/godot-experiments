extends Area2D

signal victory

func _on_Goal_body_entered(body:PhysicsBody2D):
	if body.is_in_group("Player"):
		self.queue_free()
		body.queue_free()
		emit_signal("victory")