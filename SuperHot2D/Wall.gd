extends StaticBody2D

const _ROTATION_SPEED = 30

func _process(delta):
	# Add bullet_time so it rotates FASTER when we go! :D
	self.rotation_degrees += (delta + BulletTime.bullet_time) * _ROTATION_SPEED
