extends Node

const IPC_FILENAME = "../console.txt"

func _ready() -> void:
	_append_string("hi there!")
	_append_string("second one!")

func _append_string(message:String) -> void:
	var file = File.new()
	
	# Ensure exists
	if not file.file_exists(IPC_FILENAME):
		file.open(IPC_FILENAME, File.WRITE_READ)
		file.close()
		
	file.open(IPC_FILENAME, File.READ_WRITE)
	file.seek_end()
	file.store_string(message + "\n")
	file.close()
	
