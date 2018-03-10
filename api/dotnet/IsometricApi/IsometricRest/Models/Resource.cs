using Orient.Client;
using System.Collections.Generic;

namespace IsometricRest.Models
{
    class Resource
    {
        protected ODatabase db;

        public Resource()
        {
            db = Database.Connect();
        }
        public List<ODocument> GetAll()
        {
            return db.Select().From("Resource").ToList();
        }
    }
}