const Usuario = require("../Models/Usuario");
const UsuarioService = require("../Services/UsuarioService.js");

const usuarioService = new UsuarioService();

const obtenerUsuarios = async (req, res) => {
  try {
    return res.status(501).json({ message: "Not implemented: obtenerUsuarios" }); // 501 = No implementado
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message }); // 500 = Error interno del servidor
  }
};

const obtenerUsuarioPorId = async (req, res) => {
  try {
    const { id } = req.params;
    return res.status(200).json(await usuarioService.getUsuarioId(id));
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const crearUsuario = async (req, res) => {
  try {
    const nuevoUsuario = Usuario.fromJson(req.body);
    return res.status(201).json(await usuarioService.creacionUsuario(nuevoUsuario));
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const actualizarUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    const datosActualizados = req.body;
    return res.status(501).json({ message: "Not implemented: actualizarUsuario", id });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const eliminarUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    return res.status(501).json({ message: "Not implemented: eliminarUsuario", id });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

module.exports = {
  obtenerUsuarios,
  obtenerUsuarioPorId,
  crearUsuario,
  actualizarUsuario,
  eliminarUsuario,
};

