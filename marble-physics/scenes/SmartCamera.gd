extends Camera2D

var _player:Node2D

func follow(player) -> void:
	_player = player

func _process(delta):
		if _player != null and is_instance_valid(_player):
			self.position = _player.position
	
