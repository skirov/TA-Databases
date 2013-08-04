using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace _04.DeleteFromCatalog_DOMParser
{
    class Program
    {
        static void Main(string[] args)
        {
            string file = "../../../MusicCatalogue.xml";
            XmlDocument doc = new XmlDocument();
            doc.Load(file);
            XmlNode rootNode = doc.DocumentElement;

            foreach (XmlNode node in rootNode.ChildNodes)
            {
                if (decimal.Parse(node["title"].InnerText) > 20)
                {
                    rootNode.RemoveChild(node);
                }
            }

            doc.Save(file);
        }
    }
}
