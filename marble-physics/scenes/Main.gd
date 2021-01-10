extends Node2D

onready var _fuel_gauge = $UI/FuelBar
onready var _player = $Game/Player
onready var _turn_label = $UI/TurnLabel
#onready var _shooters = $Game/Shooters

const _SCORE_MULTIPLIER:int = 500
var _turn_number:int = 1
var _raw_time_seconds:float = 0

func _ready():
	if Features.limited_fuel:
		_fuel_gauge.max_value = _player.MAX_FUEL
	else:
		_fuel_gauge.visible = false
		_turn_label.visible = false
	
	_player.setup($UI/SpeedLabel)

func _process(delta):
	_raw_time_seconds += delta
	
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
	_player.reset_fuel()
	_on_Player_used_fuel(_player.MAX_FUEL, 0) # reset gauge
	
	_turn_number += 1
	_turn_label.text = "Turn %s - Fuel: " % _turn_number


func _on_Goal_victory():
	var health_percent = _player.get_health_percent()
	var final_score = _SCORE_MULTIPLIER * health_percent / _raw_time_seconds
	$UI/ConclusionLabel.text = ("YOU WIN in %s seconds\nFinal score: %s" % [_raw_time_seconds, final_score])
	$UI/ConclusionLabel.visible = true


func _on_Player_died():
	$UI/ConclusionLabel.text = ("You DIED!!")
	$UI/ConclusionLabel.visible = true
