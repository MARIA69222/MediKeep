const Conexion = require("../Database/Conexion");

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
    let coleccion = await this.conexion.collection("historial");
    let consulta = { _id: id };
    return await coleccion.findOne(consulta);
  }

  async creacionHistorial(historial) {
    this.conexion = await this.db.connectDB();
    let coleccion = await this.conexion.collection("historial");
    await coleccion.insertOne(historial);
  }

  async getHistorial() {
    this.conexion = await this.db.connectDB();
    let coleccion = await this.conexion.collection("historial");
    return await coleccion.find({}).toArray();
  }
}

module.exports = HistorialService;
