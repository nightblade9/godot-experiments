using System;
using System.Collections.Generic;
using System.IO;
using Microsoft.Data.Sqlite;

public class DatabaseManager
{
    // Make sure it matches what Godot is using
    internal readonly string SQLITE_FILE = Path.Combine("..", "..", "ipc.sqlite.db");
    private const string MESSAGES_TABLE_NAME = "ipc_messages";

    public void LolWUT()
    {
        using (var connection = new SqliteConnection($"Data Source={SQLITE_FILE}"))
        {
            connection.Open();

            var command = connection.CreateCommand();
            command.CommandText = $"SELECT * FROM {MESSAGES_TABLE_NAME} WHERE target = 'console'";
            var idsRead = new List<int>();

            using (var reader = command.ExecuteReader())
            {
                while (reader.Read())
                {
                    var text = reader["message"].ToString();
                    var id = int.Parse(reader["id"].ToString());
                    idsRead.Add(id);
                    Console.WriteLine(text);
                }
            }

            command = connection.CreateCommand();
            command.CommandText = $"DELETE FROM {MESSAGES_TABLE_NAME} where id = $id";
            foreach (var id in idsRead)
            {
                command.Parameters.AddWithValue("$id", id);
                command.ExecuteNonQuery();
            }
        }
    }
}