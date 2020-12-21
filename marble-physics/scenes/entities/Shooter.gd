extends "res://scenes/entities/Bumper.gd"

const Bullet = preload("res://scenes/entities/Bullet.tscn")

const _SHOOT_DELAY_MILLISECONDS = 300

var _target:PhysicsBody2D
var _last_shot = OS.get_ticks_msec()

func _on_Range_body_entered(body):
	if body != self:
		print("%s locked on to %s" % [self, body])
		_target = body
	
func _on_Range_body_exited(_body):
	print("%s unlocked" % self)
	_target =  null
	
func receive_time(delta:float) -> void:
	var now = OS.get_ticks_msec()
	if _target != null and now - _last_shot >= _SHOOT_DELAY_MILLISECONDS:
		# FIRE!!!!
		print("%s firing at %s" % [self, _target])
		var direction = (_target.position - self.position).normalized()
		
		var bullet = Bullet.instance()
		bullet.position = self.position
		get_tree().get_root().add_child(bullet)
		bullet.fire(direction)
		
		_last_shot = now
