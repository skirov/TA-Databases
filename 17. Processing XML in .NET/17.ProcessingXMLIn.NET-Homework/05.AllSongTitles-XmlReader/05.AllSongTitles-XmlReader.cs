using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace _05.AllSongTitles_XmlReader
{
    class Program
    {
        static void Main(string[] args)
        {
            string file = "../../../MusicCatalogue.xml";
            using (XmlReader reader = XmlReader.Create(file))
            {
                while (reader.Read())
                {
                    if ((reader.NodeType == XmlNodeType.Element) &&
                        (reader.Name == "titile"))
                    {
                        Console.WriteLine(reader.ReadElementString());
                    }
                }
            }
        }
    }
}
