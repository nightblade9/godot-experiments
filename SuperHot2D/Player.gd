extends KinematicBody2D

const Bullet = preload("res://Bullet.tscn")

const _VELOCITY:int = 100
const _SHOT_TIME_SECONDS = 0.01

var facing:String = "down"
var bullet_time = 0.0 # UNUSED, we generate bullet time

var _last_velocity:Vector2

func _ready():
	self.add_to_group("bullet time")

func _process(delta):
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
	
	if Input.is_action_just_pressed("ui_accept") and (velocity != Vector2.ZERO or _last_velocity != Vector2.ZERO):
		var b = Bullet.instance()
		b.position = Vector2(20, 20)
		b.velocity = velocity
		b.velocity = _last_velocity
		add_child(b)
		BulletTime.bullet_time += _SHOT_TIME_SECONDS

	if velocity != Vector2.ZERO:
		_last_velocity = velocity
		self.move_and_slide(velocity * _VELOCITY)
		BulletTime.bullet_time += delta
