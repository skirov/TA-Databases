using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace _07.CreateXMLFileFromTXT
{
    class Program
    {
        static void Main(string[] args)
        {
            StreamReader readFile = new StreamReader("PersonInfo.txt");

            using (readFile)
            {
                using (XmlWriter writer = XmlWriter.Create("../../PersonInfo.xml"))
                {
                    writer.WriteStartDocument();

                    writer.WriteStartElement("PersonInfo");

                    writer.WriteElementString("Name", readFile.ReadLine());
                    writer.WriteElementString("Address", readFile.ReadLine());
                    writer.WriteElementString("PhoneNumber", readFile.ReadLine());

                    writer.WriteEndElement();

                    writer.WriteEndDocument();
                }
            }
        }
    }
}
