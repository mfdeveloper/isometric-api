using Orient.Client;

namespace IsometricRest.Models
{
    class Database
    {
        protected static string host = "localhost";
        protected static int port = 2424;
        protected static string dbName = "IsometricApi";
        protected static ODatabaseType type = ODatabaseType.Graph;
        protected static string user = "root";
        protected static string password = "root";
        protected static ODatabase db;
        public static ODatabase Connect()
        {
            db = new ODatabase(host, port, dbName, type, user, password);
            
            return db;
        }

        public static void Disconnect()
        {
            if (db != null)
            {
                db.Close();   
            }
        }
    }
}