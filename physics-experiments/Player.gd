extends KinematicBody2D

const GRAVITY = 400
const MOVE_SPEED = 300
const JUMP_SPEED = -200
var velocity = Vector2(0, 0)
var touching_antigrav = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var applied_gravity = GRAVITY
	if touching_antigrav:
		applied_gravity = -GRAVITY
		
	self.velocity.y += delta * applied_gravity
	self.move_and_slide(velocity)

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