extends KinematicBody2D

export(Resource) var stats

func _ready():
	# Uses an implicit, duck-typed interface for any 'health'-compatible resources.
	if stats:
		print(stats.health) # Prints '10'.
	else:
		print("no stats.")
