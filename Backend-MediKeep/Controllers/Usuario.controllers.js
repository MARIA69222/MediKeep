const Usuario = require("../Models/Usuario");
const UsuarioService = require("../Services/UsuarioService.js");
const { ObjectId } = require("mongodb");

const usuarioService = new UsuarioService();

const obtenerUsuarios = async (req, res) => {
  try {
    return res.status(200).json(await usuarioService.getUsuarios()); // 501 = No implementado
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message }); // 500 = Error interno del servidor
  }
};

const obtenerUsuarioPorCorreo = async (req, res) => {
  try {
    const usuario = req.body;
     const conexion = await usuarioService.db.connectDB();
    const coleccion = conexion.collection("usuarios");

    const resultado = await coleccion.findOne(
      { correo : usuario.correo }   // Busca por ObjectId correcto
    );
    if (resultado === null) {
      return res.status(404).json({ message: "Revise los datos ingresado" });
    }
    else{
    return res.status(200).json(resultado);}
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
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

const autenticar = async (req, res) => {
  try {
    const usuario = req.body;
     const conexion = await usuarioService.db.connectDB();
    const coleccion = conexion.collection("usuarios");

    const resultado = await coleccion.findOne(
      { correo : usuario.correo }   // Busca por ObjectId correcto
    );
    if (resultado === null) {
      return res.status(404).json({ message: "Revise los datos ingresado" });
    }
    else if (resultado.contrasena !== usuario.contrasena) {
      return res.status(401).json({ message: "Revise los datos ingresado" });
    }
    else{
    return res.status(200).json({message:""});}
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
    const datosActualizados = { ...req.body }; // Hacemos copia del boyd
    delete datosActualizados._id; // Nunca actualizamos el _id

    const conexion = await usuarioService.db.connectDB();
    const coleccion = conexion.collection("usuarios");

    const resultado = await coleccion.findOneAndUpdate(
      { _id: new ObjectId(id) },   // Busca por ObjectId correcto
      { $set: datosActualizados },
      { returnDocument: "after"}  // Devuelve el documento actualizado
    );
    console.log("Resultado de findOneAndUpdate:", resultado); 

    if (resultado === null) {
      return res.status(404).json({ message: "Usuario no encontrado" });
    }

    return res.status(200).json({ 
      message: "Usuario actualizado con éxito",
       usuario: resultado });

  } catch (error) {
    return res.status(500).json({
       message: "Error al actualizar usuario", 
       error: error.message });
  }
};

const eliminarUsuario = async (req, res) => {
  try {
    const { id } = req.params;
    const conexion = await usuarioService.db.connectDB();
    const coleccion = conexion.collection("usuarios");

    const resultado = await coleccion.deleteOne({ _id: new ObjectId(id) });

    if (resultado.deletedCount === 0) {
      return res.status(404).json({ message: "Usuario no encontrado" });
    }

    return res.status(200).json({ message: "Usuario eliminado con éxito" });
  } catch (error) {
    return res.status(500).json({ message: "Error al eliminar usuario", error: error.message });
  }
};

module.exports = {
  obtenerUsuarios,
  obtenerUsuarioPorId,
  crearUsuario,
  actualizarUsuario,
  eliminarUsuario,
  autenticar,
  obtenerUsuarioPorCorreo
};

