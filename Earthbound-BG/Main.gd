extends Node2D

onready var _material = $"Slime-Forest".material
var _total_time = 0.0

func _process(delta):
	_total_time += delta
	_material.set_shader_param("time", _total_time)
