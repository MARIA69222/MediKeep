const { MongoClient, ObjectId } = require("mongodb");
class Conexion {
  constructor() { 
     //this.uri = "mongodb://localhost:27017";
    this.uri = "mongodb://camila-server:MZHn2BynqRToyiKmNIc4cizUwveelwFevfpfOSwWqVcmgTXcy6P9UTHj5lkSvznv1EmvSNJzpBvzACDbcxBDew%3D%3D@camila-server.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&maxIdleTimeMS=120000&appName=@camila-server@";
     
     this.client = new MongoClient(this.uri);
  }
    
  async connectDB() {
    try {
         let db = await this.client.connect();
       return db.db("MediKeep")
    } catch (error) {
      console.error("Uff ha ocurrido un error", error);
    }
  }

}

module.exports = Conexion;
