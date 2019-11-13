extends KinematicBody2D

const GRAVITY = 400
const MOVE_SPEED = 300
const JUMP_SPEED = -200
var velocity = Vector2(0, 0)
var touching_antigrav = false

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')

	if is_on_floor() and jump:
		velocity.y = JUMP_SPEED
	if right:
		velocity.x += MOVE_SPEED
	if left:
		velocity.x -= MOVE_SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var applied_gravity = GRAVITY
	if touching_antigrav:
		applied_gravity = -GRAVITY
		
	self.velocity.y += delta * applied_gravity
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_LEFT or event.scancode == KEY_A:
			if event.is_pressed():
				self.velocity.x = -MOVE_SPEED
			else:
				self.velocity.x = 0
		elif event.scancode == KEY_RIGHT or event.scancode == KEY_D:
			if event.is_pressed():
				self.velocity.x = MOVE_SPEED
			else:
				self.velocity.x = 0
		if event.scancode == KEY_UP or event.scancode == KEY_W and event.is_pressed():
			self.velocity.y = JUMP_SPEED