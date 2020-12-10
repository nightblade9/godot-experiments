extends Node2D

func _ready():
	ConsoleManager.write_message("Hello, world!")
	var shared_data = GameData.new()
	shared_data.num_open = 0
	
	var ids = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6]
	randomize()
	ids.shuffle()
	print(str(ids))
	
	for child in get_children():
		child.initialize(shared_data)
		child.tile = ids.pop_front()

class GameData extends Resource:
	var num_open = 0
