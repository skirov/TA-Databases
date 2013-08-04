using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using System.Xml.Schema;

namespace _16.ValidateXml
{
    class Program
    {
        static void Main(string[] args)
        {
            XmlSchemaSet schemas = new XmlSchemaSet();
            schemas.Add("", "../../../MusicCatalogue.xsd");

            XDocument doc = XDocument.Load("../../../MusicCatalogue.xml"); // you can try to change the xml file to see the warnings
            string msg = "";
            doc.Validate(schemas, (o, e) =>
            {
                msg = e.Message;
            });
            Console.WriteLine(msg == "" ? "Document is valid" : "Document invalid: " + msg);
        }
    }
}
