using System;
using System.Threading;

namespace BlindConsole
{
    class Program
    {
        InterProcessMessenger ipcMessenger = new InterProcessMessenger((message) => Console.WriteLine(message));

        static void Main(string[] args)
        {
            new Program().Run();
        }

        private void Run()
        {
            ipcMessenger.Start();
            
            var readThread = new Thread(ProcessInput);
            readThread.Start();
            readThread.Join();
        }

        private void ProcessInput()
        {
            var input = "";
            while (input.ToUpper() != "quit".ToUpper())
            {
                Console.Write("Your command? ");
                input = Console.ReadLine();
                input = input.Replace('\'', '"');
                ipcMessenger.WriteMessage($"'type': 'message', 'value': '{input}'");
            }
        }
    }
}
