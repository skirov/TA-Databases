using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;

namespace _06.AllSongTitles_LINQ
{
    class Program
    {
        static void Main(string[] args)
        {
            string file = "../../../MusicCatalogue.xml";
            XDocument musicCatalogue = XDocument.Load(file);

            var allTitles = musicCatalogue.Descendants()
                .Where(t => t.Element("titile") != null)
                .Select(t => t.Element("titile").Value)
                .ToList();

            foreach (var title in allTitles)
            {
                Console.WriteLine(title);
            }
        }
    }
}
