namespace _01.Mongo_Dictionary
{
    using MongoDB.Bson;
    using MongoDB.Bson.Serialization.Attributes;
    using System;

    public class Word
    {
        [BsonId]
        public ObjectId Id { get; set; }

        public string ActualWord { get; set; }
        public string Explination { get; set; }
        
        
        public Word(string word, string explination)
        {
            this.ActualWord = word;
            this.Explination = explination;
        }

        public override string ToString()
        {
            return this.ActualWord + "=>" + this.Explination;
        }
    }
}
