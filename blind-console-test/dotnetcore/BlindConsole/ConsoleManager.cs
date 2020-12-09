using System.IO;
using System.Threading;

class ConsoleManager
{
    private Thread backgroundThread;
    private bool isRunning = false;

    public void Start()
    {
        var db = new DatabaseManager();

        this.backgroundThread = new Thread(() => {
            // Wait for Godot to launch and create the file. Easier for debugging.
            while (!File.Exists(db.SQLITE_FILE))
            {
                Thread.Sleep(100);
            }

            while (this.isRunning) {
                // Will read/write in chunks of buffer.Length
                db.LolWUT();
                Thread.Sleep(100);
            }
        });
        
        this.isRunning = true;
        backgroundThread.Start();
    }

    ~ConsoleManager()
    {
        this.isRunning = false;
        backgroundThread.Join();
    }
}