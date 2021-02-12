extends Node2D

onready var _cycler = $Cycler
onready var _outliner = $MechaSpore
onready var _sine_white = $MechaSpore2
onready var _sine = $MechaSpore3

func _process(delta):
	var positive_time = sin(_cycler.cyclic_time) + 1.0 # maps [-1..1] to [0..2]
	_outliner.material.set_shader_param("line_thickness", 3.0 * positive_time)
	_sine_white.material.set_shader_param("time", positive_time)
	_sine.material.set_shader_param("time", positive_time)
