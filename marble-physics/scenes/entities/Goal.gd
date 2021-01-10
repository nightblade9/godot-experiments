extends Area2D

signal victory

var _players_left:int = 1

func expect_players(n:int) -> void:
	_players_left = n

func _on_Goal_body_entered(body:PhysicsBody2D):
	if body.is_in_group("Player"):
		body.queue_free()
		_players_left -= 1
		if _players_left <= 0: 
			emit_signal("victory")
