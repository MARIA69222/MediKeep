const Historial = require("../Models/Historial");
const HistorialService = require("../Services/HistorialService");
const historialService = new HistorialService();

// Obtener todos los historiales
const obtenerHistoriales = async (req, res) => {
  try {
    return res.status(200).json(await historialService.getHistorial());
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Obtener un historial por ID
const obtenerHistorialPorId = async (req, res) => {
  try {
    const { id } = req.params;
    return res.status(200).json(await historialService.getHistorialId(id));
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Crear un nuevo historial
const crearHistorial = async (req, res) => {
  try {
    const nuevoHistorial = Historial.fromJson(req.body);
    return res.status(201).json(await historialService.creacionHistorial(nuevoHistorial));
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Actualizar historial (no implementado)
const actualizarHistorial = async (req, res) => {
  try {
    const { id } = req.params;
    const datos = req.body;
    return res.status(501).json({ message: "No implementado: actualizarHistorial", id });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

// Eliminar historial (no implementado)
const eliminarHistorial = async (req, res) => {
  try {
    const { id } = req.params;
    return res.status(501).json({ message: "No implementado: eliminarHistorial", id });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

module.exports = {
  obtenerHistoriales,
  obtenerHistorialPorId,
  crearHistorial,
  actualizarHistorial,
  eliminarHistorial,
};

