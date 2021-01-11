extends Node2D

onready var _fuel_gauge = $UI/FuelBar
onready var _players = $Game/Level/Players
onready var _turn_label = $UI/TurnLabel
onready var _goal = $Game/Level/Goal

#onready var _shooters = $Game/Shooters

const _SCORE_MULTIPLIER:int = 500
var _turn_number:int = 1
var _raw_time_seconds:float = 0

func _ready():
	if Features.limited_fuel:
		_fuel_gauge.max_value = _players.get_child(0).MAX_FUEL
	else:
		_fuel_gauge.visible = false
		_turn_label.visible = false
	
	for player in _players.get_children():
		player.setup($UI/SpeedLabel)
	
	_goal.expect_players(_players.get_child_count())

func _process(delta):
	_raw_time_seconds += delta
	
	if _players.get_child_count() == 1:
		$Game/Camera2D.position = _players.get_child(0).position
	else:
		var average_position = Vector2.ZERO
		for player in _players.get_children():
			average_position += player.position
		average_position /= _players.get_child_count()
		
		$Game/Camera2D.position = average_position
	
func _on_Player_used_fuel(fuel_left:float, delta:float):
	if Features.limited_fuel:
		_fuel_gauge.value = fuel_left
		
		# Tell monsters to move
#		if delta > 0:
#			for shooter in _shooters.get_children():
#				if shooter.has_method("receive_time"):
#					shooter.receive_time(delta)
				
func _on_Player_turn_over():
	# TODO: do stuff, like increment points, apply AI, etc. first
	# THEN, after AIs etc. are all done, reset to next turn.
	for player in _players:
		player.reset_fuel()
	_on_Player_used_fuel(_players.get_child(0).MAX_FUEL, 0) # reset gauge
	
	_turn_number += 1
	_turn_label.text = "Turn %s - Fuel: " % _turn_number


func _on_Goal_victory():
	var total_health = 0.0
	
	for player in _players.get_children():
		total_health += player.get_health_percent()
	
	var health_percent = total_health / _players.get_child_count()
	
	var final_score = _SCORE_MULTIPLIER * health_percent / _raw_time_seconds
	$UI/ConclusionLabel.text = ("YOU WIN in %s seconds\nFinal score: %s" % [_raw_time_seconds, final_score])
	$UI/ConclusionLabel.visible = true

func _on_Player_died():
	$UI/ConclusionLabel.text = ("You DIED!!")
	$UI/ConclusionLabel.visible = true
