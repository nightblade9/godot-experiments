extends Node

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

# Make sure it matches what .NET is using
const SQLITE_FILE = "../ipc.sqlite.db"
const MESSAGES_TABLE_NAME = "ipc_messages"

func _ready() -> void:
	_initialize_database()

func write_message(text:String) -> void:
	var db = _connect_to_db()
	db.insert_row(MESSAGES_TABLE_NAME, { "target": "console", "message": text })
	db.close_db()

func _initialize_database() -> void:
	var directory = Directory.new()
	directory.remove(SQLITE_FILE)

	var db = _connect_to_db()
	var table_definition : Dictionary = Dictionary()
	table_definition["id"] = {"data_type":"int", "primary_key": true, "auto_increment": true }
	table_definition["target"] = { "data_type":"char(64)", "not_null": true }
	table_definition["message"] = { "data_type":"text", "not_null": true }
	
	db.create_table(MESSAGES_TABLE_NAME, table_definition)
	
	db.close_db()

func _connect_to_db() -> SQLite:
	var db = SQLite.new()
	db.path = SQLITE_FILE
	db.verbose_mode = true
	# Open the database using the db_name found in the path variable
	db.open_db()
	return db
