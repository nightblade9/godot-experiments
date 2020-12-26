extends Node2D

onready var _arrow:Sprite = $Arrow
onready var _player_marbles:Node2D = $Player
onready var _cpu_marbles:Node2D = $CPU

var _selected:Node2D
var _target:Node2D

func _ready():
	_arrow.visible = false
	
	for marble in _player_marbles.get_children():
		marble.connect("on_clicked", self, "_on_marble_clicked")
	
	for marble in _cpu_marbles.get_children():
		marble.connect("on_clicked", self, "_on_target_clicked")

func _on_marble_clicked(marble:Node2D) -> void:
	_target = null # clicking who to shoot, deselects target
	_selected = marble
	_arrow.visible = true
	_arrow.position = marble.position - Vector2(0, _arrow.texture.get_height())

func _on_target_clicked(target:Node2D) -> void:
	_target = target
	if _selected != null:
		# ready to go
		_selected.fire_at(_target)
		_selected = null
		_target = null
		_arrow.visible = false
