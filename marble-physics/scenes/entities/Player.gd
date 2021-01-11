extends KinematicBody2D

signal used_fuel # emits fuel_left
signal turn_over
signal died

const MAX_FUEL:int = 100
const _SPEED:int = 10
const _FUEL_CONSUMPTION_RATE:int = 50 # n * delta per tick
const _STOP_VELOCITY_AMPLITUDE:int = 10
const _COLLISION_VELOCITY_LOSS_PERCENTAGE:float = 0.5 # 0.3 => lose 30% velocity on bumper hit

var velocity:Vector2
var decay:float = 0.01 # % per tick

var _fuel_left:float = MAX_FUEL
var _speed_label:Label

##### experiment
var _total_health = 10
var _health = self._total_health
var _last_hit_on = 0
var _invincible:bool = false
const _POST_HIT_INVINCIBILITY_SECONDS:float = 1.0

func _ready():
	self.add_to_group("Player")

func setup(speed_label:Label) -> void:
	self._speed_label = speed_label

func reset_fuel():
	_fuel_left = MAX_FUEL
	
func get_health_percent() -> float:
	return 1.0 * _health / _total_health

func _process(_delta) -> void:
	if self._invincible:
		var hit_on = OS.get_system_time_msecs()
		var hit_time = (hit_on - self._last_hit_on) / 1000
		if hit_time < _POST_HIT_INVINCIBILITY_SECONDS:
			self.modulate = Color(1, 0.7, 0.4, 0.5) # faded-out red
		else:
			self._invincible = false
			self.modulate = Color(1, 1, 1, 1)

func _physics_process(delta):
	var display_speed:int = velocity.length() / 10 # tops up around 90-95
	if _speed_label != null:
		_speed_label.text = "Speed: %s" % display_speed
	
		if Features.has_health:
			_speed_label.text = "%s/%s" % [self._health, self._total_health]
	
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

func on_collide(take_damage:bool) -> void:
	# Called when we collide with bumpers
	self.velocity = self.velocity * (1 - _COLLISION_VELOCITY_LOSS_PERCENTAGE)
	
	if Features.has_health and take_damage and not self._invincible:
		var hit_on = OS.get_system_time_msecs()
		var hit_time = (hit_on - self._last_hit_on) / 1000.0
		if hit_time >= _POST_HIT_INVINCIBILITY_SECONDS:
			self._health -= 3
			self._last_hit_on = hit_on
			
			if self._health <= 0:
				emit_signal("died")
				self.queue_free()
			else:
				self._invincible = true
				
