namespace _01.Mongo_Dictionary
{
    using MongoDB.Driver;
    using System;

    public class Program
    {
        static void Main(string[] args)
        {
            var connectionStr = "mongodb://localhost";
            var client = new MongoClient(connectionStr);
            var server = client.GetServer();
            var db = server.GetDatabase("MongoDictionary");
            MongoCollection<Word> dictionaryCollection = db.GetCollection<Word>("Words");

            MongoDictionary mongoDictionary = new MongoDictionary(dictionaryCollection);

            UI.DrawMenu();

            mongoDictionary["asdf"] = "pe6enceto";

            while (true)
            {
                Console.Write("Please enter a command: ");
                string command = Console.ReadLine().Trim();

                if (command == "Exit")
                {
                    break;
                }

                Engine.ParseCommand(command, mongoDictionary);
            }

        }
    }
}
