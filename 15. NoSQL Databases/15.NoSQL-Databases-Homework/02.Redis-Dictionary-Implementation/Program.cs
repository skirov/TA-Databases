namespace _02.Redis_Dictionary_Implementation
{
    using ServiceStack.Redis;
    using System;

    class Program
    {
        static void Main(string[] args)
        {
            using (RedisClient client = new RedisClient())
            {
                RedisDictionary redisDictionary = new RedisDictionary(client, "redisDict");

                redisDictionary.Add("gosho", "ribata");
                redisDictionary.Add("pesho", "akademiqta");
                redisDictionary.Add("kiki", "razvrata");

                Console.WriteLine(redisDictionary["kiki"]);

                Console.WriteLine(redisDictionary.ContainsKey("pesho"));
                redisDictionary.Remove("pesho");
                Console.WriteLine(redisDictionary.ContainsKey("pesho"));

                foreach (var item in redisDictionary)
                {
                    Console.WriteLine("{0} -> {1}", item.Key, item.Value);
                }

                redisDictionary["kiki"] = "obshtata";

                Console.WriteLine(redisDictionary["kiki"]);
            }
        }
    }
}
