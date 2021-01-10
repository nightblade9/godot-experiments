extends Node2D

onready var _fuel_gauge = $UI/FuelBar
onready var _player = $Game/Player
onready var _turn_label = $UI/TurnLabel
#onready var _shooters = $Game/Shooters

var _turn_number:int = 1

func _ready():
	if Features.limited_fuel:
		_fuel_gauge.max_value = _player.MAX_FUEL
	else:
		_fuel_gauge.visible = false
		_turn_label.visible = false
	
	_player.setup($UI/SpeedLabel)
		
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
