using System;
using System.Xml.Xsl;

class Program
{
    static void Main()
    {
        XslCompiledTransform xslt =
          new XslCompiledTransform();
        xslt.Load("../../../MusicCatalogue.xslt");
        xslt.Transform("../../../MusicCatalogue.xml", "../../../14.MusicCatalogue.html");
        Console.WriteLine("Successfully transformed!");
    }
}
