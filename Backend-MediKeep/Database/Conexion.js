const { MongoClient, ObjectId } = require("mongodb");
class Conexion {
  constructor() { 
    //this.uri = "mongodb://localhost:27017";
    this.uri = "mongodb+srv://camilla:<Akitutisun18>@cluster0.r9osiz4.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
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
