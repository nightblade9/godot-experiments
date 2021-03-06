extends Node2D

onready var _fuel_gauge = $UI/FuelBar
onready var _turn_label = $UI/TurnLabel

var _player
var _goal
var _camera

#onready var _shooters = $Game/Shooters

const _SCORE_MULTIPLIER:int = 500
var _turn_number:int = 1
var _raw_time_seconds:float = 0
var _current_level = 0
var _level

var _levels = [
	preload("res://scenes/levels/EasyLevel.tscn"),
	preload("res://scenes/levels/TrickyLevel.tscn"),
	preload("res://scenes/levels/BumperZoneLevel.tscn"),
	preload("res://scenes/levels/SpeedLevel.tscn")
]


func _ready():
	if Features.limited_fuel:
		_fuel_gauge.max_value = _player.MAX_FUEL
	else:
		_fuel_gauge.visible = false
		_turn_label.visible = false

	_load_current_level()

func _load_current_level() -> void:
	_load_level(_current_level)
	
	_player = _level.get_node("Player")
	_goal = _level.get_node("Goal")
	_camera = $Game/SmartCamera
	
	_camera.position = Vector2.ZERO
	_camera.follow(_player)
	
	_player.setup($UI/SpeedLabel)
	_player.connect("died", self, "_on_Player_died")
	
	if not _goal.is_connected("victory", self, "_on_Goal_victory"):
		_goal.connect("victory", self, "_on_Goal_victory")
	
func _load_level(index:int) -> void:
	var clazz = _levels[index]
	var instance = clazz.instance()
	instance.name = "Level"
	$Game.add_child(instance)
	_level = instance

func _process(delta):
	_raw_time_seconds += delta
	
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
	_on_Player_used_fuel(_player.MAX_FUEL, 0) # reset guage
	
	_turn_number += 1
	_turn_label.text = "Turn %s - Fuel: " % _turn_number

func _on_Goal_victory():
	if _current_level < len(_levels) - 1:
		_current_level += 1
		_level.queue_free()
		call_deferred("_on_next_level")
	else:
		$UI/ConclusionLabel.text = ("YOU WIN!")
		$UI/ConclusionLabel.visible = true
	
func _on_next_level():
	_load_current_level()

func _on_Player_died():
	$UI/ConclusionLabel.text = ("You DIED!!")
	$UI/ConclusionLabel.visible = true
