const { ObjectId } = require("mongodb");
const Conexion = require("../Database/Conexion");
const Usuario = require("../Models/Usuario");

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
    const coleccion = await this.conexion.collection("usuarios");
    const consulta = { _id: new ObjectId(id) };
    return await coleccion.findOne(consulta);
  }

  async creacionUsuario(usuario) {
    this.conexion = await this.db.connectDB();
    const coleccion = await this.conexion.collection("usuarios");
    const existe = usuario.toJson();
    const resultado = await coleccion.insertOne(existe);
    usuario.idMongo = resultado.insertedId;
    return JSON.parse(JSON.stringify(usuario));
  }

  async getUsuarios() {
    this.conexion = await this.db.connectDB();
    const coleccion = await this.conexion.collection("usuarios");
    return await coleccion.find({}).toArray();
  }
}

module.exports = UsuarioService;

