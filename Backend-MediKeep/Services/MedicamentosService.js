// services/medicamento.service.js
const Conexion = require("../Database/Conexion");

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

  // Obtener un medicamento por ID
  async getMedicamentoId(id) {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("medicamentos");
    const consulta = { _id: id }; // puedes ajustar si usas ObjectId
    return await coleccion.findOne(consulta);
  }

  // Crear un medicamento
  async crearMedicamento(medicamento) {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("medicamentos");
    await coleccion.insertOne(medicamento);
  }

  // Obtener todos los medicamentos
  async getMedicamentos() {
    this.conexion = await this.db.connectDB();
    const coleccion = this.conexion.collection("medicamentos");
    return await coleccion.find({}).toArray();
  }
}

module.exports = MedicamentoService;
