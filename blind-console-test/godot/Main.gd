extends Node2D

var Card = preload("res://Card.gd")
var InterProcessMessenger = preload("res://InterProcessMessenger.gd")

var _shared_data = GameData.new()

func _ready():
	var ipc = InterProcessMessenger.new()
	add_child(ipc)
	
	ipc.write_message("Hello, world!")
	ipc.connect("on_message", self, "_on_ipc_message")
	
	var ids = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6]
	randomize()
	ids.shuffle()
	print(str(ids))
	
	for child in get_children():
		if child is Card:
			child.initialize(_shared_data)
			child.tile = ids.pop_front()
		
	assert(len(ids) == 0) # gave all IDs away but some are left?!

func _process(_delta):
	if len(_shared_data.open_tiles) == 2 and _shared_data.open_tiles[0].tile == _shared_data.open_tiles[1].tile:
		for tile in _shared_data.open_tiles:
			tile.complete()
		_shared_data.open_tiles.clear()

func _on_ipc_message(message):
	print("Received message: %s" % message)

class GameData extends Resource:
	var open_tiles = []
	var set_complete = false # are we completing a pair and emptying open_tiles?
