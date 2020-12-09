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
        string buffer = "";
        this.backgroundThread = new Thread(() => {
            using (var fs = new FileStream("test.txt", FileMode.Open, FileAccess.Read, FileShare.ReadWrite | FileShare.Delete)) {
                using (var reader = new StreamReader(fs)) {
                    while (this.isRunning) {
                        var line = reader.ReadLine();
                        if (line != null) {
                            buffer += line;
                            if (line.Contains('\n'))
                            {
                                Console.WriteLine(buffer);
                                buffer = "";
                                Console.Out.Flush();
                            }
                        }
                        Thread.Sleep(100);
                    }
                }
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