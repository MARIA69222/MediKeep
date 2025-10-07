const { ObjectId } = require("mongodb");
const Conexion = require("../Database/Conexion");
const Medicamento = require("../Models/Medicamento");

class MedicamentoService {
  constructor() {
    this.db = new Conexion();
  }

  set conexion(conexion) {
    this._conexion = conexion;
  }

  get conexion() {
    return this._conexion;
  }

  // ✅ Función para actualizar estados automáticamente
  async finalizarMedicamentos() {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("medicamentos");

    const activos = await coleccion.find({ estado: "activo" }).toArray();
    const ahora = new Date();

    for (const med of activos) {
      const inicio = new Date(med.horaInicio);
      const duracionDias = parseInt(med.duracion) || 0;
      const fin = new Date(inicio);
      fin.setDate(inicio.getDate() + duracionDias);

      if (ahora >= fin) {
        await coleccion.updateOne(
          { _id: med._id },
          { $set: { estado: "finalizado" } }
        );
      }
    }
  }

  async getMedicamentoId(id) {
    await this.finalizarMedicamentos(); // ✅ actualizar estado antes de devolver
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("medicamentos");
    return await coleccion.findOne({ _id: new ObjectId(id) });
  }

  async creacionMedicamento(medicamento) {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("medicamentos");
    const data = medicamento.toJson();
    const resultado = await coleccion.insertOne(data);
    medicamento.idMongo = resultado.insertedId;
    return JSON.parse(JSON.stringify(medicamento));
  }

  async getMedicamentos() {
    await this.finalizarMedicamentos(); // ✅ actualizar estados antes de devolver
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("medicamentos");
    return await coleccion.find({}).toArray();
  }

  async actualizarMedicamento(id, datos) {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("medicamentos");
    return await coleccion.updateOne(
      { _id: new ObjectId(id) },
      { $set: datos }
    );
  }

  async eliminarMedicamento(id) {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("medicamentos");
    return await coleccion.deleteOne({ _id: new ObjectId(id) });
  }
}

module.exports = MedicamentoService;



