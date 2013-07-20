namespace _01.Mongo_Dictionary
{
    using System;

    public static class UI
    {
        public static void DrawMenu()
        {
            Console.WriteLine("{0}", new string('*', Console.BufferWidth));
            Console.WriteLine("{0}", new string('*', Console.BufferWidth));

            Console.WriteLine("Dictionary app with MongoDB.");
            Console.WriteLine("Command options:");
            Console.WriteLine("  -Add - adds a word to the dictionary: usage 'Add word-explanation'");
            Console.WriteLine("  -Remove - removes a word from the dictionary: usage 'Remove word'");
            Console.WriteLine("  -Find - findes a word from the dictionary: usage 'Find word'");
            Console.WriteLine("  -List - lists all words from the dictionary: usage 'List all'");
            Console.WriteLine("  -Exit - exits from the dictionary: usage Exit");
            Console.WriteLine();

            Console.WriteLine("{0}", new string('*', Console.BufferWidth));
            Console.WriteLine("{0}", new string('*', Console.BufferWidth));
        }
    }
}
