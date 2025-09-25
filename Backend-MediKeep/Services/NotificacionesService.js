// Services/NotificacionService.js
const Conexion = require("../Database/Conexion");

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

  // Obtener una notificación por ID
  async getNotificacionId(id) {
    this.conexion = await this.db.connectDB();
    let coleccion = await this.conexion.collection("notificaciones");
    let consulta = { _id: id };
    return await coleccion.findOne(consulta);
  }

  // Crear nueva notificación
  async creacionNotificacion(notificacion) {
    this.conexion = await this.db.connectDB();
    let coleccion = await this.conexion.collection("notificaciones");
    await coleccion.insertOne(notificacion);
  }

  // Obtener todas las notificaciones
  async getNotificaciones() {
    this.conexion = await this.db.connectDB();
    let coleccion = await this.conexion.collection("notificaciones");
    return await coleccion.find({}).toArray();
  }

  // Actualizar una notificación por ID
  async actualizarNotificacion(id, datos) {
    this.conexion = await this.db.connectDB();
    let coleccion = await this.conexion.collection("notificaciones");
    await coleccion.updateOne({ _id: id }, { $set: datos });
  }

  // Eliminar una notificación por ID
  async eliminarNotificacion(id) {
    this.conexion = await this.db.connectDB();
    let coleccion = await this.conexion.collection("notificaciones");
    await coleccion.deleteOne({ _id: id });
  }
}

module.exports = NotificacionService;

