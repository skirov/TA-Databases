namespace _01.Mongo_Dictionary
{
    using MongoDB.Driver;
    using MongoDB.Driver.Builders;
    using System;
    using System.Linq;
    using MongoDB.Driver.Linq;
    using System.Collections;
    using System.Collections.Generic;

    public class MongoDictionary : IEnumerable
    {
        private MongoCollection<Word> dictionaryCollection;
        private IQueryable<Word> collectionQuery;

        public MongoDictionary(MongoCollection<Word> dictionaryCollection)
        {
            this.dictionaryCollection = dictionaryCollection;
            this.collectionQuery = dictionaryCollection.AsQueryable<Word>();
        }

        public void Add(string key, string value)
        {
            if (!ContainsKey(key))
            {
                Word newWord = new Word(key, value);
                dictionaryCollection.Insert(newWord);
            }
            else
            {
                throw new ArgumentException("The key already exists.");
            }
        }

        public void Remove(string key)
        {
            if (ContainsKey(key))
            {
                var objectToRemove = Query.EQ("ActualWord", key);

                dictionaryCollection.Remove(objectToRemove);
            }
            else
            {
                throw new ArgumentException("The key does not exist.");
            }
        }

        public bool ContainsKey(string key)
        {
            int countOccurences = this.collectionQuery.Where(x => x.ActualWord == key).ToList().Count;

            if (countOccurences > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public string this[string key]
        {
            get
            {
                if (ContainsKey(key))
                {
                    return this.collectionQuery
                        .Where(x => x.ActualWord == key)
                        .ToList()
                        .First().ToString();
                }
                else
                {
                    throw new ArgumentException("The key does not exist.");
                }
            }

            set
            {
                var valueToSet = Update.Set("Explination", value);

                var wordToUpdate = Query.EQ("ActualWord", key);
                
                dictionaryCollection.Update(wordToUpdate, valueToSet);
            }
        }

        public IEnumerator<MongoDictItem> GetEnumerator()
        {
            var allWords = this.collectionQuery.ToList();

            for (int i = 0; i < allWords.Count; i ++)
            {
                yield return new MongoDictItem(allWords[i].ActualWord, allWords[i].Explination);
            }
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
    }
}
