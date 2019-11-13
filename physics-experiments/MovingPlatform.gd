# Adapted from https://godotforums.org/discussion/20573/moving-platforms
extends KinematicBody2D
export(int) var distance = 100
export(int) var speed = 100
# I'm going to assume the starting position is the starting point
var point_start
var point_end
var distance_along_path = 0
var going_towards_end = true

func _ready():
	point_start = global_position
	point_end = Vector2(global_position.x + distance, global_position.y)
	
func _physics_process(delta):
	# Add distance to the path. NOTE: This will not work with large values in path_speed!
	distance_along_path += delta
	# Check if the platform is farther along the path, and therefore is beyond the point we want
	# to change directions at. If it is,  then reset distance_along_path and flip going_towards_end
	# so we start going in the opposite direction.
	if (distance_along_path >= 1):
		distance_along_path = 0
		going_towards_end = !going_towards_end
		
	# Move the platform from point to point based on going_towards_end.
	if (going_towards_end == true):
		move_and_slide(Vector2(speed, 0))
	else:
		move_and_slide(Vector2(-speed, 0))