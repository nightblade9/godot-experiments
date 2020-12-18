extends KinematicBody2D

const _SPEED:int = 10

var velocity:Vector2
var decay:float = 0.01 # % per tick

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x -= _SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x += _SPEED
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= _SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.y += _SPEED
	
	velocity = velocity * (1 - decay)
	
	self.move_and_slide(velocity)
