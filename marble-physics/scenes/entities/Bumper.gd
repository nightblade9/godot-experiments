extends RigidBody2D

const Player = preload("res://scenes/entities/Player.gd")

const _PLAYER_HIT_DAMAGE = 40
const _BUMPER_HIT_DAMAGE = 25
const _ENVIRONMENT_HIT_DAMAGE = 10

onready var _health_bar = $HealthBar

func _physics_process(_delta):
	self.rotation_degrees = 0 # never rotate, throws off UI, firing, etc.

func _on_Bumper_body_entered(body):
	if body is Player:
		_health_bar.value -= _PLAYER_HIT_DAMAGE
	elif body is RigidBody2D:
		_health_bar.value -= _BUMPER_HIT_DAMAGE
	elif body is StaticBody2D:
		_health_bar.value -= _ENVIRONMENT_HIT_DAMAGE
	
	if _health_bar.value <= 0:
		self.queue_free()
