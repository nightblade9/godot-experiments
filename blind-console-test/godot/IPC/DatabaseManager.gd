extends Node

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

# Make sure it matches what .NET is using
const _SQLITE_FILE = "../ipc.sqlite.db"
const _MESSAGES_TABLE_NAME = "ipc_messages"

func _ready() -> void:
	_recreate_database()

func write_message(json:String) -> void:
	var database = _connect_to_db()
	database.insert_row(_MESSAGES_TABLE_NAME, { "target": "Console", "message": json })
	database.close_db()
	
func get_messages(target:String) -> Array: # string[]
	var database = _connect_to_db()
	var rows = database.select_rows(_MESSAGES_TABLE_NAME, "target = '%s'" % target, ["*"])
	
	var row_ids = []
	var messages = []
	
	for row in rows:
		row_ids.append(int(row["id"]))
		messages.append(row["message"])
	
	for id in row_ids:
		database.query("DELETE FROM %s WHERE id = %s" % [_MESSAGES_TABLE_NAME, id])

	database.close_db()
	
	return messages

func _recreate_database() -> void:
	var directory = Directory.new()
	directory.remove(_SQLITE_FILE)

	var db = _connect_to_db()
	var table_definition : Dictionary = Dictionary()
	table_definition["id"] = {"data_type":"int", "primary_key": true, "auto_increment": true }
	table_definition["target"] = { "data_type":"char(64)", "not_null": true }
	table_definition["message"] = { "data_type":"text", "not_null": true } # JSON payload
	
	db.create_table(_MESSAGES_TABLE_NAME, table_definition)
	
	db.close_db()

func _connect_to_db() -> SQLite:
	var db = SQLite.new()
	db.path = _SQLITE_FILE
	#db.verbose_mode = true # extremely useful for debugging bad queries
	
	# Open the database using the db_name found in the path variable
	db.open_db()
	return db
