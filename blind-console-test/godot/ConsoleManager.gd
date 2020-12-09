extends Node

# Must match C# code
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
	if not file.file_exists(TO_CONSOLE_FILE):
		file.open(TO_CONSOLE_FILE, File.WRITE_READ)
		file.close()
		
	var result = file.open(TO_CONSOLE_FILE, File.WRITE)
	# Strange: works if you open the file in VSCode and add to it, but not GD...
	if (result != OK):
		push_error("Failed to open file for writing; result was " + str(result))
	file.seek_end()
	file.store_string(message + "\n")
	file.close()
	
