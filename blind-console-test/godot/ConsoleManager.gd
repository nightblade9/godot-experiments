extends Node

signal on_input

# Where we write stuff to the console
const IPC_COMMANDS_FILENAME = "../console-commands.txt"
# Where we read responses the user typed into the console
const IPC_INPUT_FILENAME = "../console-input.txt"

# Prefixes for commands
const WRITE_LINE_PREFIX = "[WRITE_LINE]"
const WRITE_PARTIAL_PREFIX = "[WRITE_TEXT]"
const READ_LINE_PREFIX = "[READ_LINE]"
const READ_CHARACTER_PREFIX = "[READ_CHAR]"

func _ready() -> void:
	# delete files if they pre-existed
	var directory = Directory.new()
	directory.remove(IPC_COMMANDS_FILENAME)
	directory.remove(IPC_INPUT_FILENAME)
	
	# valid messages:
	# write: no newline
	# write_line: ...
	# read: one character
	# read_line: ...
	write("Hello, world!", true)
	write("What is your name? ", false)
	read(true)
	var name = yield(self, "on_input")
	
	write("Hello %s! Can you type a number please?" % name)
	read(false)
	var number = yield(self, "on_input")
	
	var int_number = int(number)
	write("Ten times that number is " + str(int_number * 10) + "!")

func write(message:String, is_line:bool = false) -> void:
	if is_line:
		self._append_string(WRITE_LINE_PREFIX + message)
	else:
		self._append_string(WRITE_PARTIAL_PREFIX + message)

func read(is_line:bool = false) -> void:
	if is_line:
		_append_string(READ_LINE_PREFIX)
	else:
		_append_string(READ_CHARACTER_PREFIX)
		
	var file = File.new()
	
	# Ensure exists
	while not file.file_exists(IPC_INPUT_FILENAME):
		yield(get_tree().create_timer(0.1), "timeout")
		
	file.open(IPC_INPUT_FILENAME, File.READ)
	var input_string = file.get_as_text()
	file.close()
	
	# Delete file
	assert(Directory.new().remove(IPC_INPUT_FILENAME) == OK)
	
	if is_line:
		emit_signal("on_input", input_string)
	else:
		emit_signal("on_input", input_string[0])
		
func _append_string(message:String) -> void:
	var file = File.new()
	
	# Ensure exists
	if not file.file_exists(IPC_COMMANDS_FILENAME):
		file.open(IPC_COMMANDS_FILENAME, File.WRITE_READ)
		file.close()
		
	file.open(IPC_COMMANDS_FILENAME, File.READ_WRITE)
	file.seek_end()
	file.store_string(message + "\n")
	file.close()
	
