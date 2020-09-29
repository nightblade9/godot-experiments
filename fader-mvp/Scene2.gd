extends Node2D

func _on_Area2D_body_entered(body):
	call_deferred("_change_scene")

func _change_scene():
	SceneChanger.change_scene("res://Scene1.tscn")
	
