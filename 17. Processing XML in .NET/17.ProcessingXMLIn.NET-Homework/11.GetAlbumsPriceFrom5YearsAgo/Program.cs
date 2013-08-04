using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace _11.GetAlbumsPriceFrom5YearsAgo
{
    class Program
    {
        static void Main(string[] args)
        {
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load("../../../MusicCatalogue.xml");
            string xPathQuery = "/catalog/album";

            XmlNodeList albums = xmlDoc.SelectNodes(xPathQuery);
            foreach (XmlNode album in albums)
            {
                int currentYear = int.Parse(album.SelectSingleNode("year").InnerText);
                if (currentYear < DateTime.Now.Year - 5)
                {
                    Console.WriteLine("{0} ${1}", album.SelectSingleNode("name").InnerText, album.SelectSingleNode("price").InnerText);
                }
            }
        }
    }
}
