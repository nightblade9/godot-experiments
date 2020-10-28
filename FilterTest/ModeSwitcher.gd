extends Node2D

const JumboBeam = preload("res://Beams/JumboBeam.gd")

var _current = 0

var modes = [
	["Normal", []],
	["Jumbo", [JumboBeam.new()]],
	["2x Jumbo", [JumboBeam.new(), JumboBeam.new()]]
]

func _on_Button_pressed():
	_current = (_current + 1) % len(modes)
	$Button.text = modes[_current][0]

func get_filters() -> Array:
	return modes[_current][1]
