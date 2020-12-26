extends Node2D

onready var _arrow:Sprite = $Arrow
onready var _player_marbles:Node2D = $Player
onready var _cpu_marbles:Node2D = $CPU

func _ready():
	_arrow.visible = false
	
	for marble in _player_marbles.get_children():
		marble.connect("on_clicked", self, "_on_marble_clicked")
	
	for marble in _cpu_marbles.get_children():
		marble.connect("on_clicked", self, "_on_target_clicked")

func _on_marble_clicked(marble:RigidBody2D) -> void:
	_arrow.visible = true
	_arrow.position = marble.position - Vector2(0, _arrow.texture.get_height())

func _on_target_clicked(target:RigidBody2D) -> void:
	print("Target = %s" % target)
