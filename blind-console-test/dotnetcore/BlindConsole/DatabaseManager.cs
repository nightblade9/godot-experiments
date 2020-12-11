using Microsoft.Data.Sqlite;
using System.Collections.Generic;
using System.IO;

public class DatabaseManager
{
    // Make sure it matches what Godot is using
    internal readonly string SQLITE_FILE = Path.Combine("..", "..", "ipc.sqlite.db");
    private const string MESSAGES_TABLE_NAME = "ipc_messages";

    public IEnumerable<string> GetMessages(string target)
    {
        using (var connection = new SqliteConnection($"Data Source={SQLITE_FILE}"))
        {
            connection.Open();

            var command = connection.CreateCommand();
            command.CommandText = $"SELECT * FROM {MESSAGES_TABLE_NAME} WHERE target = $target";
            command.Parameters.AddWithValue("$target", target);

            var idsRead = new List<int>();
            var jsonTextsRead = new List<string>();

            using (var reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    var jsonText = reader["message"].ToString();
                    var id = int.Parse(reader["id"].ToString());
                    idsRead.Add(id);
                    jsonTextsRead.Add(jsonText);
                }
            }

            command = connection.CreateCommand();
            command.CommandText = $"DELETE FROM {MESSAGES_TABLE_NAME} where id = $id";
            foreach (var id in idsRead)
            {
                command.Parameters.AddWithValue("$id", id);
                command.ExecuteNonQuery();
            }

            return jsonTextsRead;
        }
    }

    public void WriteMessage(string json)
    {
        using (var connection = new SqliteConnection($"Data Source={SQLITE_FILE}"))
        {
            connection.Open();

            var command = connection.CreateCommand();
            command.CommandText = $"INSERT INTO {MESSAGES_TABLE_NAME} (target, message) values ($target, $message)";
            command.Parameters.AddWithValue("$target", "Godot");
            command.Parameters.AddWithValue("$message", json);
            command.ExecuteNonQuery();
        }
    }
}