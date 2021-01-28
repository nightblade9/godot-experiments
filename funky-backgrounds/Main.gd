extends Node2D

var _total_time:float

func _process(delta):
	_total_time += delta
	$vertical.position.y -= delta * 100
	if $vertical.position.y <= -192:
		$vertical.position.y += 192
	$vertical.position.x -= (delta * 20)
	if $vertical.position.x <= -128:
		$vertical.position.x += 128

	$horizontal.position.x += delta * 50
	if $horizontal.position.x >= 0:
		$horizontal.position.x -= 128
	$horizontal.position.y += sin(_total_time)
