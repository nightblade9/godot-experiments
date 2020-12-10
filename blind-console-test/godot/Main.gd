extends Node2D

func _ready():
	ConsoleManager.write_message("Hello, world!")
	var shared_data = GameData.new()
	shared_data.num_open = 0
	
	for child in get_children():
		child.initialize(shared_data)

class GameData extends Resource:
	var num_open = 0
