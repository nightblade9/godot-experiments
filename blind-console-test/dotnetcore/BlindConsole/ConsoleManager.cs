using System;
using System.IO;
using System.Threading;

class ConsoleManager
{
    // Must match C# code
    // Where we write stuff to the console
    private readonly string TO_CONSOLE_FILE = Path.Join("..", "to-console.txt");
    // Where we read responses the user typed into the console
    private readonly string TO_GODOT_FILE = Path.Join("..", "to-godot.txt");

    private Thread backgroundThread;
    private bool isRunning = false;

    public void Start()
    {
        this.backgroundThread = new Thread(() => {
            while (this.isRunning) {
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