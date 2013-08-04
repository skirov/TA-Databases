using System;
using System.Xml.Xsl;

class Program
{
    //Create an XSL stylesheet, which transforms the file catalog.xml 
    //into HTML document, formatted for viewing in a standard Web-browser.

    static void Main()
    {
        XslCompiledTransform xslt = new XslCompiledTransform();
        xslt.Load("../../Catalogue.xsl");
        xslt.Transform("../../catalogue.xml", "../../catalogue.html");
    }
}