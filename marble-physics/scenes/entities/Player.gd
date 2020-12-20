extends KinematicBody2D

signal used_fuel

const MAX_FUEL:int = 100
const _SPEED:int = 10
const _FUEL_CONSUMPTION_RATE:int = 50 # n * delta per tick
const _STOP_VELOCITY_AMPLITUDE:int = 50

var velocity:Vector2
var decay:float = 0.01 # % per tick

var _fuel_left:float = MAX_FUEL

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
		
		if consume_fuel:
			_fuel_left -= delta * _FUEL_CONSUMPTION_RATE
			emit_signal("used_fuel", _fuel_left)
		
	velocity = velocity * (1 - decay)
	if not consume_fuel and velocity.length() <= _STOP_VELOCITY_AMPLITUDE:
		velocity = Vector2.ZERO
	
	# naive: no bounce
	# self.move_and_slide(velocity)

	# bounce code from: https://docs.godotengine.org/en/3.2/tutorials/physics/using_kinematic_body_2d.html#bouncing-reflecting
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()
