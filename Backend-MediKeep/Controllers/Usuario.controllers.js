const Usuario = require("../Models/Usuario")
const UsuarioService = require ("../Services/UsuarioService.js");
const usuarioService = new UsuarioService();


const obtenerUsuarios = async (req, res) => {
  try {
    
    return res.status(501).json({ message: 'Not implemented: obtenerUsuarios' }); //501=No implementado”
  } catch (error) {
    return res.status(500).json({ message: 'Error interno', error: error.message }); // 500 = “Error interno del servidor”
  }
};

const obtenerUsuarioPorId = async (req, res) => {
  try {
    const { id } = req.params;
  return res.status(200).json(await usuarioService.getUsuarioId(id));
   // return res.status(501).json({ message: 'Not implemented: obtenerUsuarioPorId', id });
  } catch (error) {
    return res.status(500).json({ message: 'Error interno', error: error.message });
  }
};

const crearUsuario = async (req, res) => {
  try {
    const datosActualizados = req.body;
    await usuarioService.creacionUsuario(datosActualizados)
    // Aquí luego guardaríamos un nuevo usuario
    return res.status(201).json({ message: 'Not implemented: crearUsuario' });
  } catch (error) {
    return res.status(500).json({ message: 'Error interno', error: error.message });
  }
};

const actualizarUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    const datosActualizados = req.body;
    // Aquí luego actualizaríamos el usuario con ese ID
    return res.status(501).json({ message: 'Not implemented: actualizarUsuario', id });
  } catch (error) {
    return res.status(500).json({ message: 'Error interno', error: error.message });
  }
};

const eliminarUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    // Aquí luego eliminaríamos el usuario con ese ID
    return res.status(501).json({ message: 'Not implemented: eliminarUsuario', id });
  } catch (error) {
    return res.status(500).json({ message: 'Error interno', error: error.message });
  }
};

module.exports = {
  obtenerUsuarios,
  obtenerUsuarioPorId,
  crearUsuario,
  actualizarUsuario,
  eliminarUsuario
};
