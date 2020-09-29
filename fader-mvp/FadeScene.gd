extends CanvasLayer

signal fade_done
export var fade_time_seconds:int = 1

var _total_time:float = 0
var _enabled = false

func start():
	_enabled = true

func _process(delta):
	if not _enabled:
		return
		
	if _total_time >= fade_time_seconds:
		emit_signal("fade_done")
		queue_free()
		
	_total_time += delta
	var fade_amount = abs(sin(_total_time))
	$Sprite.material.set_shader_param("dissolve_amount", fade_amount)
