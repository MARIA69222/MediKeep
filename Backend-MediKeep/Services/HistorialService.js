const { ObjectId } = require("mongodb");
const Conexion = require("../Database/Conexion");
const Historial = require("../Models/Historial");

class HistorialService {
  constructor() {
    this.db = new Conexion();
  }

  set conexion(conexion) {
    this._conexion = conexion;
  }

  get conexion() {
    return this._conexion;
  }

  async getHistorialId(id) {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("historial");
    return await coleccion.findOne({ _id: new ObjectId(id) });
  }

  async creacionHistorial(historial) {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("historial");
    const data = historial.toJson();
    const resultado = await coleccion.insertOne(data);
    historial.idMongo = resultado.insertedId;
    return JSON.parse(JSON.stringify(historial));
  }

  async getHistorial() {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("historial");
    return await coleccion.find({}).toArray();
  }
}

module.exports = HistorialService;

