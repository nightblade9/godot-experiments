using System;
using System.IO;
using System.Threading;

class InterProcessMessenger
{
    private DatabaseManager db = new DatabaseManager();
    private Thread backgroundThread;
    private bool isRunning = false;
    private Action<string> onMessageCallback;

    public InterProcessMessenger(Action<string> onMessageCallback)
    {
        this.onMessageCallback = onMessageCallback;
    }

    public void Start()
    {
        this.backgroundThread = new Thread(() => {
            // Wait for Godot to launch and create the file. Easier for debugging.
            while (!File.Exists(db.SQLITE_FILE))
            {
                Thread.Sleep(100);
            }

            while (this.isRunning) {
                var messages = db.GetMessages("Console");
                foreach (var message in messages)
                {
                    this.onMessageCallback.Invoke(message);
                }
                Thread.Sleep(100);
            }
        });
        
        this.isRunning = true;
        backgroundThread.Start();
    }

    public void WriteMessage(string json)
    {
        db.WriteMessage(json);       
    }

    ~InterProcessMessenger()
    {
        this.isRunning = false;
        backgroundThread.Join();
    }
}