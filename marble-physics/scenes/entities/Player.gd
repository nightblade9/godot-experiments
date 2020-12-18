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
	
	# naive: no bounce
	# self.move_and_slide(velocity)

	# bounce code from: https://docs.godotengine.org/en/3.2/tutorials/physics/using_kinematic_body_2d.html#bouncing-reflecting
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()
