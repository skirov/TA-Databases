using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Xsl;

namespace StudentsXML
{
    class Program
    {
        static void Main(string[] args)
        {
            XslCompiledTransform xslt = new XslCompiledTransform();
            xslt.Load("../../xmlFiles/Students.xsl");
            xslt.Transform("../../xmlFiles/Students.xml", "../../Students.html");
        }
    }
}
