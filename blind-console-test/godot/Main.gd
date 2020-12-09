extends Node2D

func _ready():
	ConsoleManager.write_message("Hello, world!")

func _on_ColorRect_pressed():
	ConsoleManager.write_message("clicked at " + str($ColorRect.rotation_degrees))
