const Conexion = require("../Database/Conexion");
const baseBatos = require("../Database/Conexion");

class UsuarioService {
  constructor() {
    this.db = new Conexion();
  }
  set conexion(conexion) {
    this._conexion = conexion;
  }
  get conexion() {
    return this._conexion;
  }
  async getUsuarioId(id) {
    this.conexion = await this.db.connectDB();
    let coleccion = await this.conexion.collection("usuarios");
    let consulta = { edad: id };
    return await coleccion.findOne(consulta);
  }

  async creacionUsuario(usuario) {
    this.conexion = await this.db.connectDB();
    let coleccion = await this.conexion.collection("usuarios");
    await coleccion.insertOne(usuario);
    await coleccion.insertOne({
      nombre: "camila",
      edad: id,
      fechaNacimiento: "28/02/2025",
      enfermedade: "N",
      contraseña: "123456",
    });
  }

  async getUsuarios() {
    this.conexion = await this.db.connectDB();
    let coleccion = await this.conexion.collection("usuarios");
    return await coleccion.find({}).toArray();
  }
}

module.exports = UsuarioService;
