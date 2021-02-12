extends Node2D

onready var _cycler = $Cycler
onready var _sprite = $MechaSpore

func _process(delta):
	var positive_time = sin(_cycler.cyclic_time) + 1.0 # maps [-1..1] to [0..2]
	_sprite.material.set_shader_param("line_thickness", 3.0 * positive_time)
	print(str(3 * positive_time))
