using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

class Program
{
    private static void InsertPlayerScore(string playerName, double playerScore, OleDbConnection excelCon)
    {
        OleDbCommand insertPlayer = new OleDbCommand(@"INSERT INTO [Sheet1$] (Name, Score) VALUES (@playerName, @playerScore)", excelCon);
        insertPlayer.Parameters.AddWithValue("@playerName", playerName);
        insertPlayer.Parameters.AddWithValue("@playerScore", playerScore);

        insertPlayer.ExecuteNonQuery();
    }
    //
    static void Main(string[] args)
    {
        string path = @"../../scores.xlsx";
        string connStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=Excel 12.0;";

        OleDbConnection excelCon = new OleDbConnection(connStr);

        excelCon.Open();

        using (excelCon)
        {
            InsertPlayerScore("Pesho strelata", 15, excelCon);
            Console.WriteLine("Row is inserted.");
        }
    }
}
