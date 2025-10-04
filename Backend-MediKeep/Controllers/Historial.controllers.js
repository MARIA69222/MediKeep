const Historial = require("../Models/Historial");
const HistorialService = require("../Services/HistorialService");
const { ObjectId } = require("mongodb");

const historialService = new HistorialService();

// Obtener todos los historiales
const obtenerHistoriales = async (req, res) => {
  try {
    return res.status(200).json(await historialService.obtenerHistoriales());
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Obtener un historial por ID
const obtenerHistorialPorId = async (req, res) => {
  try {
    const { id } = req.params;
    return res.status(200).json(await historialService.obtenerHistorialPorId(id));
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Crear un nuevo historial
const crearHistorial = async (req, res) => {
  try {
    const nuevoHistorial = Historial.fromJson(req.body);
    return res.status(201).json(await historialService.crearHistorial(nuevoHistorial));
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Actualizar historial
const actualizarHistorial = async (req, res) => {
  try {
    const { id } = req.params;
    const datosActualizados = { ...req.body };
    delete datosActualizados._id;

    const conexion = await historialService.db.connectDB();
    const coleccion = conexion.collection("historial");

    const resultado = await coleccion.findOneAndUpdate(
      { _id: new ObjectId(id) },
      { $set: datosActualizados },
      { returnDocument: "after" }
    );

    if (!resultado) {
      return res.status(404).json({ message: "Historial no encontrado" });
    }

    return res.status(200).json({
      message: "Historial actualizado con éxito",
      historial: resultado
    });
  } catch (error) {
    return res.status(500).json({
      message: "Error al actualizar historial",
      error: error.message
    });
  }
};

// Eliminar historial
const eliminarHistorial = async (req, res) => {
  try {
    const { id } = req.params;
    const conexion = await historialService.db.connectDB();
    const coleccion = conexion.collection("historial");

    const resultado = await coleccion.deleteOne({ _id: new ObjectId(id) });

    if (resultado.deletedCount === 0) {
      return res.status(404).json({ message: "Historial no encontrado" });
    }

    return res.status(200).json({ message: "Historial eliminado con éxito" });
  } catch (error) {
    return res.status(500).json({
      message: "Error al eliminar historial",
      error: error.message
    });
  }
};

module.exports = {
  obtenerHistoriales,
  obtenerHistorialPorId,
  crearHistorial,
  actualizarHistorial,
  eliminarHistorial,
};


