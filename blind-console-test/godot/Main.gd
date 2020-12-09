extends Node2D

func _ready():
	_write("Hello, world!")

func _on_ColorRect_pressed():
	_write("clicked at " + str($ColorRect.rotation_degrees))

func _write(message:String) -> void:
	ConsoleManager.write_message(message)
	$Label.text = message
