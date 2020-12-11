extends Node

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

signal on_message

# TODO: factor out DB layer
# Make sure it matches what .NET is using
const _SQLITE_FILE = "../ipc.sqlite.db"
const _MESSAGES_TABLE_NAME = "ipc_messages"
const _MESSAGE_TARGET = "Godot"

var _is_running = false
var _read_thread:Thread

func _ready() -> void:
	_initialize_database()
	
	_read_thread = Thread.new()
	var result = _read_thread.start(self, "_thread_function", "unused data")
	assert(result == OK)
	
	_is_running = true

func write_message(json:String) -> void:
	var db = _connect_to_db()
	db.insert_row(_MESSAGES_TABLE_NAME, { "target": "Console", "message": json })
	db.close_db()

func _initialize_database() -> void:
	var directory = Directory.new()
	directory.remove(_SQLITE_FILE)

	var db = _connect_to_db()
	var table_definition : Dictionary = Dictionary()
	table_definition["id"] = {"data_type":"int", "primary_key": true, "auto_increment": true }
	table_definition["target"] = { "data_type":"char(64)", "not_null": true }
	table_definition["message"] = { "data_type":"text", "not_null": true } # JSON payload
	
	db.create_table(_MESSAGES_TABLE_NAME, table_definition)
	
	db.close_db()

func _thread_function(_user_data) -> void:
	var db = _connect_to_db()
	
	while _is_running:
		var messages = _get_messages(db)
		for message in messages:
			emit_signal("on_message", message)
			
		yield(get_tree().create_timer(0.1), "timeout")
		
	db.close_db()

func _connect_to_db() -> SQLite:
	var db = SQLite.new()
	db.path = _SQLITE_FILE
	#db.verbose_mode = true # extremely useful for debugging bad queries
	
	# Open the database using the db_name found in the path variable
	db.open_db()
	return db

###########################################

func _get_messages(db:SQLite) -> Array: # string[]
	var rows = db.select_rows(_MESSAGES_TABLE_NAME, "target = '%s'" % _MESSAGE_TARGET, ["*"])
	var row_ids = []
	var messages = []
	
	for row in rows:
		row_ids.append(int(row["id"]))
		messages.append(row["message"])
	
	for id in row_ids:
		db.query("DELETE FROM %s WHERE id = %s" % [_MESSAGES_TABLE_NAME, id])
	
	return messages

func _exit_tree():
	_is_running = false
	_read_thread.wait_to_finish()
