extends Node2D

const JumboBeam = preload("res://Beams/JumboBeam.gd")
const SplitterBeam = preload("res://Beams/SplitterBeam.gd")

var _current = 0

var modes = [
	["Normal", []],
	["Jumbo", [JumboBeam.new()]],
	["2x Jumbo", [JumboBeam.new(), JumboBeam.new()]],
	["Splitter", [SplitterBeam.new()]],
	["Jumbo Splitter", [JumboBeam.new(), SplitterBeam.new()]],
	["Splitter Jumbo", [SplitterBeam.new(), JumboBeam.new()]],
	["Splitter Splitter", [SplitterBeam.new(), SplitterBeam.new()]],
	["Splitter Splitter Jumbo", [SplitterBeam.new(), SplitterBeam.new(), JumboBeam.new()]]
]

func _on_Button_pressed():
	_current = (_current + 1) % len(modes)
	$Button.text = modes[_current][0]

func get_filters() -> Array:
	return modes[_current][1]
