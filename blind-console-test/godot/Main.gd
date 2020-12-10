extends Node2D

var _shared_data = GameData.new()

func _ready():
	ConsoleManager.write_message("Hello, world!")
	
	var ids = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6]
	randomize()
	ids.shuffle()
	print(str(ids))
	
	for child in get_children():
		child.initialize(_shared_data)
		child.tile = ids.pop_front()
		
	assert(len(ids) == 0) # gave all IDs away but some are left?!

func _process(delta):
	if len(_shared_data.open_tiles) == 2 and _shared_data.open_tiles[0].tile == _shared_data.open_tiles[1].tile:
		for tile in _shared_data.open_tiles:
			tile.complete()
		_shared_data.open_tiles.clear()

class GameData extends Resource:
	var open_tiles = []
	var set_complete = false # are we completing a pair and emptying open_tiles?
