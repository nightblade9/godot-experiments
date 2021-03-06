extends KinematicBody2D

const Bullet = preload("res://Bullet.tscn")

const _VELOCITY:int = 100

var facing:String = "down"

var _last_velocity:Vector2
var _switcher

# Jumbo
# Wave
# Spread
# Explode

func initialize(switcher):
	_switcher = switcher

func _process(_delta):
	var velocity:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1
		facing = "down"
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -1
		facing = "up"
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
		facing = "right"
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -1
		facing = "left"
	
	self.move_and_slide(velocity * _VELOCITY)
	
	if Input.is_action_just_pressed("ui_accept") and (velocity != Vector2.ZERO or _last_velocity != Vector2.ZERO):
		
		var b = Bullet.instance()
		b.position = Vector2(20, 20)
		b.velocity = velocity
		if b.velocity == Vector2.ZERO:
			b.velocity = _last_velocity
			
		var bullets = [b]
		for beam in _switcher.get_filters():
			bullets = beam.fire(bullets)
		
		for bullet in bullets:
			add_child(bullet)

	if velocity != Vector2.ZERO:
		_last_velocity = velocity
