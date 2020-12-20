extends Node2D

onready var _fuel_gauge = $UI/FuelBar
onready var _player = $Game/Player
onready var _turn_label = $UI/TurnLabel

var _turn_number:int = 1

func _ready():
	_fuel_gauge.max_value = _player.MAX_FUEL

func _on_Player_used_fuel(fuel_left:float):
	_fuel_gauge.value = fuel_left

func _on_Player_turn_over():
	# TODO: do stuff, like increment points, apply AI, etc. first
	# THEN, after AIs etc. are all done, reset to next turn.
	
	
	_player.reset_fuel()
	_on_Player_used_fuel(_player.MAX_FUEL) # reset gauge
	
	_turn_number += 1
	_turn_label.text = "Turn %s - Fuel: " % _turn_number
