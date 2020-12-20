extends Node2D

onready var _fuel_gauge = $UI/FuelBar
onready var _player = $Game/Player

func _ready():
	_fuel_gauge.max_value = _player.MAX_FUEL


func _on_Player_used_fuel(fuel_left:float):
	_fuel_gauge.value = fuel_left
