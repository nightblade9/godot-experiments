extends Camera2D

var _players = []

func follow(players) -> void:
	_players = players

func _process(delta):
	if len(_players) == 1 and _players[0] != null:
		self.position = _players[0].position
	else:
		var count = 0
		var average_position = Vector2.ZERO
		for player in _players:
			if player != null: # didn't make it to the goal yet
				average_position += player.position
				count += 1
				
		average_position /= count
		
		self.position = average_position
	
