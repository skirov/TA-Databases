using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace _02.ArtistsInformation
{
    class Program
    {
        static void Main(string[] args)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load("../../../MusicCatalogue.xml");
            XmlNode rootNode = doc.DocumentElement;

            Dictionary<string, int> artists = new Dictionary<string, int>();

            foreach (XmlNode node in rootNode.ChildNodes)
            {
                if (artists.ContainsKey(node["artist"].InnerText))
                {
                    artists[node["artist"].InnerText]++;
                }
                else
                {
                    artists.Add(node["artist"].InnerText, 1);
                }
            }

            foreach (var artist in artists)
            {
                Console.WriteLine("Artist:{0} - {1} albums", artist.Key, artist.Value);
            }
        }
    }
}
