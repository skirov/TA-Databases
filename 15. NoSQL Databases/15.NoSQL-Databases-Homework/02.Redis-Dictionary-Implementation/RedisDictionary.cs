namespace _02.Redis_Dictionary_Implementation
{
    using ServiceStack.Redis;
    using System;
    using System.Collections;
    using System.Collections.Generic;

    public class RedisDictionary : IEnumerable<string>
    {
        private RedisClient client;
        private string dictionaryName;

        public RedisDictionary(RedisClient client, string dictionaryName)
        {
            this.client = client;
            this.dictionaryName = dictionaryName;
        }

        public void Add(string key, string value)
        {
            this.client.HSet(this.dictionaryName, key.ToAsciiCharArray(), value.ToAsciiCharArray());
        }

        public void Remove(string key)
        {
            this.client.HDel(this.dictionaryName, key.ToAsciiCharArray());
        }

        public bool ContainsKey(string key)
        {
            long containsValue = this.client.HExists(this.dictionaryName, key.ToAsciiCharArray());

            if (containsValue == 1)
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
                byte[] valueToReturn = this.client.HGet(this.dictionaryName, key.ToAsciiCharArray());

                return valueToReturn.StringFromByteArray();
            }

            set 
            {
                this.client.HSet(this.dictionaryName, key.ToAsciiCharArray(), value.ToAsciiCharArray());
            }
        }

        public IEnumerator<string> GetEnumerator()
        {
            byte[][] allValues = this.client.HGetAll(this.dictionaryName);

            foreach (var item in allValues)
            {
                yield return item.StringFromByteArray();
            }
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
    }
}
