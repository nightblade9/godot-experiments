extends Node2D

func _ready():
	ConsoleManager.write("Hello, world!")

func _on_ColorRect_pressed():
	ConsoleManager.write("Clicked at " + str($ColorRect.rotation_degrees))
