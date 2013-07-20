namespace _01.Mongo_Dictionary
{
    using System;

    public struct MongoDictItem
    {
        private string key;
        private string value;

        public MongoDictItem(string key, string value)
        {
            this.key = key;
            this.value = value;
        }

        public string Value
        {
            get { return value; }
        }
        
        public string Key
        {
            get { return key; }
        }
        
    }
}
