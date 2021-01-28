extends StaticBody2D

const _BREAK_SPEED:int = 80 # pretty high, hard to achieve

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		var speed = body.get_speed()
		if speed >= _BREAK_SPEED:
			self.queue_free()
		else:
			body.show_too_slow()
