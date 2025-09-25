const { MongoClient, ObjectId } = require("mongodb");
class Conexion {
  constructor() { 
     this.uri = "mongodb://localhost:27017";
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
