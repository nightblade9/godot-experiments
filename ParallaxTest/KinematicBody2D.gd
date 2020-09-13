extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_key_pressed(KEY_LEFT):
		self.move_and_slide(Vector2(-1, 0) * 100)
	elif Input.is_key_pressed(KEY_RIGHT):
		self.move_and_slide(Vector2(1, 0) * 100)

	if Input.is_key_pressed(KEY_UP):
		self.move_and_slide(Vector2(0, -1) * 100)
	elif Input.is_key_pressed(KEY_DOWN):
		self.move_and_slide(Vector2(0, 1) * 100)
