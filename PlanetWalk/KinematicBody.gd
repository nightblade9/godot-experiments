extends KinematicBody

export var planetoid_path:NodePath
export var speed = 75

onready var _planetoid:Spatial = get_node(planetoid_path)

const _ROTATION_SPEED:float = 5.0

func _physics_process(delta):
	var direction:Vector3 = Vector3.ZERO
	
	if Input.is_action_just_pressed("ui_accept"):
		self.rotation_degrees = Vector3.ZERO

	if Input.is_action_pressed("ui_left"):
		self.rotation_degrees.y += _ROTATION_SPEED
	if Input.is_action_pressed("ui_right"):
		self.rotation_degrees.y -= _ROTATION_SPEED
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()

	var velocity = Vector3.ZERO
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	var up_vector = self.translation - _planetoid.translation
	print("up is %s" % up_vector)
	#velocity.y -= fall_acceleration * delta
	move_and_slide(velocity, up_vector)
