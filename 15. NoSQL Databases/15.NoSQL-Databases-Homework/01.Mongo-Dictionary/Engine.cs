namespace _01.Mongo_Dictionary
{
    using MongoDB.Driver;
    using MongoDB.Driver.Builders;
    using System;

    public static class Engine
    {
        public static void ParseCommand(string command, MongoDictionary mongoDictCollection)
        {
            int commandEndIndex = command.IndexOf(' ');

            string parsedCommand = command.Substring(0, commandEndIndex).Trim();

            switch (parsedCommand)
            {
                case "Add": AddToDictionary(command, mongoDictCollection);
                    Console.WriteLine("Word is added successfully.");
                    break;
                case "Remove": RemoveFromDictionary(command, mongoDictCollection);
                    Console.WriteLine("Word is removed successfully.");
                    break;
                case "Find":
                    string result = FindFromDictionary(command, mongoDictCollection);
                    Console.WriteLine(result);
                    break;
                case "List": ListAllFromDictionary(mongoDictCollection);
                    break;
                default: Console.WriteLine("Wrong command. Try again.");
                    break;
            }
        }

        public static void AddToDictionary(string command, MongoDictionary mongoDictionary)
        {
            int wordStartIndex = command.IndexOf(' ') + 1;
            int wordEndIndex = command.IndexOf('-');

            string word = command.Substring(wordStartIndex, wordEndIndex - wordStartIndex).Trim();
            string explination = command.Substring(wordEndIndex + 1, (command.Length - 1) - wordEndIndex);

            mongoDictionary.Add(word, explination);
        }

        public static void RemoveFromDictionary(string command, MongoDictionary mongoDictionary)
        {
            int wordStartIndex = command.IndexOf(' ') + 1;

            string word = command.Substring(wordStartIndex, command.Length - wordStartIndex).Trim();

            mongoDictionary.Remove(word);
        }

        public static string FindFromDictionary(string command, MongoDictionary mongoDictionary)
        {
            int wordStartIndex = command.IndexOf(' ') + 1;

            string word = command.Substring(wordStartIndex, command.Length - wordStartIndex).Trim();

            return mongoDictionary[word];
        }

        public static void ListAllFromDictionary(MongoDictionary mongoDictionary)
        {
            foreach (var item in mongoDictionary)
            {
                Console.WriteLine("{0}=>{1}", item.Key, item.Value);
            }
        }
    }
}
