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

  async getMedicamentoId(id) {
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


