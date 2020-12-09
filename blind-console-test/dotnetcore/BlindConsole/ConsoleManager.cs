using System;
using System.IO;
using System.Linq;
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
        var readBuffer = new char[4096];

        this.backgroundThread = new Thread(() => {
            using (var fs = new FileStream("test.txt", FileMode.Open, FileAccess.Read, FileShare.ReadWrite | FileShare.Delete)) {
                using (var reader = new StreamReader(fs)) {
                    while (this.isRunning) {
                        // Will read/write in chunks of buffer.Length
                        var readCount = reader.ReadBlock(readBuffer, 0, readBuffer.Length);
                        if (readCount > 0) {
                            var slice = new ArraySegment<char>(readBuffer, 0, readCount);
                            Console.Write(slice.ToArray());
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