const { ObjectId } = require("mongodb");
const Conexion = require("../Database/Conexion");
const Notificacion = require("../Models/Notificacion");

class NotificacionService {
  constructor() {
    this.db = new Conexion();
  }

  set conexion(conexion) {
    this._conexion = conexion;
  }

  get conexion() {
    return this._conexion;
  }

  async getNotificacionId(id) {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("notificaciones");
    return await coleccion.findOne({ _id: new ObjectId(id) });
  }

  async creacionNotificacion(notificacion) {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("notificaciones");
    const data = notificacion.toJson();
    const resultado = await coleccion.insertOne(data);
    notificacion.idMongo = resultado.insertedId;
    return JSON.parse(JSON.stringify(notificacion));
  }

  async getNotificaciones() {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("notificaciones");
    return await coleccion.find({}).toArray();
  }

  async actualizarNotificacion(id, datos) {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("notificaciones");
    return await coleccion.updateOne(
      { _id: new ObjectId(id) },
      { $set: datos }
    );
  }

  async eliminarNotificacion(id) {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("notificaciones");
    return await coleccion.deleteOne({ _id: new ObjectId(id) });
  }
}

module.exports = NotificacionService;


