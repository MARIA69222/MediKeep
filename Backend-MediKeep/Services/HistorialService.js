const { ObjectId } = require("mongodb");
const Conexion = require("../Database/Conexion");
const Historial = require("../Models/Historial");

class HistorialService {
  constructor() {
    this.db = new Conexion();
  }

  // Obtener todos los historiales
  async obtenerHistoriales() {
    const conexion = await this.db.connectDB();
    const coleccion = conexion.collection("historial");
    return await coleccion.find({}).toArray();
  }

  // Obtener un historial por ID
  async obtenerHistorialPorId(id) {
    const conexion = await this.db.connectDB();
    const coleccion = conexion.collection("historial");
    return await coleccion.findOne({ _id: new ObjectId(id) });
  }

  // Crear historial
  async crearHistorial(historial) {
    const conexion = await this.db.connectDB();
    const coleccion = conexion.collection("historial");
    const data = historial.toJson();
    const resultado = await coleccion.insertOne(data);
    return { ...data, _id: resultado.insertedId };
  }

  // Actualizar historial
  async actualizarHistorial(id, datosActualizados) {
    const conexion = await this.db.connectDB();
    const coleccion = conexion.collection("historial");
    return await coleccion.updateOne(
      { _id: new ObjectId(id) },
      { $set: datosActualizados }
    );
  }

  // Eliminar historial
  async eliminarHistorial(id) {
    const conexion = await this.db.connectDB();
    const coleccion = conexion.collection("historial");
    return await coleccion.deleteOne({ _id: new ObjectId(id) });
  }
}

module.exports = HistorialService;




