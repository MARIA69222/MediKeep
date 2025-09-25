const Historial = require("../Models/Historial");
const HistorialService = require("../Services/HistorialService.js");
const historialService = new HistorialService();

const obtenerHistoriales = async (req, res) => {
  try {
    return res.status(501).json({ message: "Not implemented: obtenerHistoriales" });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const obtenerHistorialPorId = async (req, res) => {
  try {
    const { id } = req.params;
    return res.status(200).json(await historialService.getHistorialId(id));
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const crearHistorial = async (req, res) => {
  try {
    const datos = req.body;
    await historialService.creacionHistorial(datos);
    return res.status(201).json({ message: "Not implemented: crearHistorial" });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const actualizarHistorial = async (req, res) => {
  try {
    const { id } = req.params;
    const datos = req.body;
    return res.status(501).json({ message: "Not implemented: actualizarHistorial", id });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const eliminarHistorial = async (req, res) => {
  try {
    const { id } = req.params;
    return res.status(501).json({ message: "Not implemented: eliminarHistorial", id });
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

