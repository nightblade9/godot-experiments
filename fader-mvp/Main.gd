extends Node2D

func _ready():
	call_deferred("_start_game")

func _start_game():
	SceneChanger.change_scene("res://Scene1.tscn")
