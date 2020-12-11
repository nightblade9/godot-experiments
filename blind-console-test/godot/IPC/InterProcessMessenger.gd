extends Node

const DatabaseManager = preload("res://IPC/DatabaseManager.gd")

signal on_message

const _MESSAGE_TARGET = "Godot"

var _is_running = false
var _read_thread:Thread
var _db:DatabaseManager

func _ready() -> void:
	_read_thread = Thread.new()
	var result = _read_thread.start(self, "_thread_function", "unused data")
	assert(result == OK)
	
	_is_running = true

	_db = DatabaseManager.new()
	add_child(_db)

func _thread_function(_user_data) -> void:
	while _is_running:
		var messages = _db.get_messages(_MESSAGE_TARGET)
		for message in messages:
			emit_signal("on_message", message)
			
		yield(get_tree().create_timer(0.1), "timeout")
		
	_db.close_db()

func write_message(json:String) -> void:
	_db.write_message(json)

func _exit_tree():
	_is_running = false
	_read_thread.wait_to_finish()
