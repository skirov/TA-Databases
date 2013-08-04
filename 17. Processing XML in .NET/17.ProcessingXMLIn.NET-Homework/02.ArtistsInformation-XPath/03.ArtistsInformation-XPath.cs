using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.XPath;

namespace _03.ArtistsInformation_XPath
{
    class Program
    {
        static void Main(string[] args)
        {
            XPathDocument document = new XPathDocument("../../../MusicCatalogue.xml");
            XPathNavigator navigate = document.CreateNavigator();

            Dictionary<string, int> artists = new Dictionary<string, int>();

            XPathExpression expresion = navigate.Compile("/catalogue/album/artist");
            XPathNodeIterator nodes = navigate.Select(expresion);

            while(nodes.MoveNext())
            {
                XPathNavigator currentNode = nodes.Current.Clone();

                if (artists.ContainsKey(currentNode.Value))
                {
                    artists[currentNode.Value]++;
                }
                else
                {
                    artists.Add(currentNode.Value, 1);
                }
            }

            foreach (var artist in artists)
            {
                Console.WriteLine("Artist:{0} - {1} albums", artist.Key, artist.Value);
            }
        }
    }
}
