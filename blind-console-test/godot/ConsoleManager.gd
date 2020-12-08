extends Node

signal on_input

# Where we write stuff to the console
const TO_CONSOLE_FILE = "../to-console.txt"
# Where we read responses the user typed into the console
const TO_GODOT_FILE = "../to-godot.txt"

func _ready() -> void:
	# delete files if they pre-existed
	var directory = Directory.new()
	directory.remove(TO_CONSOLE_FILE)
	directory.remove(TO_GODOT_FILE)
	
func write(message:String) -> void:
	var file = File.new()
	
	# Ensure exists
	if not file.file_exists(IPC_COMMANDS_FILENAME):
		file.open(IPC_COMMANDS_FILENAME, File.WRITE_READ)
		file.close()
		
	file.open(IPC_COMMANDS_FILENAME, File.READ_WRITE)
	file.seek_end()
	file.store_string(message + "\n")
	file.close()
	
