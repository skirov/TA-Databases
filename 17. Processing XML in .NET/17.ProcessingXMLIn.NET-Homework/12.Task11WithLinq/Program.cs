using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace _12.Task11WithLinq
{
    class Program
    {
        static void Main(string[] args)
        {
            XDocument xmlDoc = XDocument.Load("../../../MusicCatalogue.xml");

            var albums =
                from album in xmlDoc.Descendants("album")
                where int.Parse(album.Element("year").Value) < 2008
                select new
                {
                    Title = album.Element("name").Value,
                    Price = album.Element("price").Value
                };
            Console.WriteLine("Found {0} albums:", albums.Count());
            foreach (var album in albums)
            {
                Console.WriteLine(" Album Name {0}-> Price {1}.00 USD", album.Title, album.Price);
            }
        }
    }
}
