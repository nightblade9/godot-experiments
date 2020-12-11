using System;

namespace BlindConsole
{
    class Program
    {
        static void Main(string[] args)
        {
            var console = new InterProcessMessenger((message) => Console.WriteLine(message));
            console.Start();
        }
    }
}
