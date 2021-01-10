extends KinematicBody2D

signal used_fuel # emits fuel_left
signal turn_over

const MAX_FUEL:int = 100
const _SPEED:int = 10
const _FUEL_CONSUMPTION_RATE:int = 50 # n * delta per tick
const _STOP_VELOCITY_AMPLITUDE:int = 10
const _COLLISION_VELOCITY_LOSS_PERCENTAGE:float = 0.5 # 0.3 => lose 30% velocity on bumper hit

var velocity:Vector2
var decay:float = 0.01 # % per tick

var _fuel_left:float = MAX_FUEL

func reset_fuel():
	_fuel_left = MAX_FUEL

func _physics_process(delta):
	var consume_fuel = false
	
	if _fuel_left > 0:
		if Input.is_action_pressed("ui_left"):
			velocity.x -= _SPEED
			consume_fuel = true
		elif Input.is_action_pressed("ui_right"):
			velocity.x += _SPEED
			consume_fuel = true
			
		if Input.is_action_pressed("ui_up"):
			velocity.y -= _SPEED
			consume_fuel = true
		elif Input.is_action_pressed("ui_down"):
			velocity.y += _SPEED
			consume_fuel = true
		
		if Features.limited_fuel and consume_fuel:
			_fuel_left -= delta * _FUEL_CONSUMPTION_RATE
			emit_signal("used_fuel", _fuel_left, delta)
		
	velocity = velocity * (1 - decay)
	# Out of fuel? Slow to a stop
	if _fuel_left <= 0 and not consume_fuel and velocity.length() <= _STOP_VELOCITY_AMPLITUDE:
		velocity = Vector2.ZERO # Moving slow enough; stop completely.
		emit_signal("turn_over")
	
	# naive: no bounce
	# self.move_and_slide(velocity)

	# bounce code from: https://docs.godotengine.org/en/3.2/tutorials/physics/using_kinematic_body_2d.html#bouncing-reflecting
	# bounce off of walls
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func on_collide():
	# Called when we collide with bumpers
	self.velocity = self.velocity * (1 - _COLLISION_VELOCITY_LOSS_PERCENTAGE)
