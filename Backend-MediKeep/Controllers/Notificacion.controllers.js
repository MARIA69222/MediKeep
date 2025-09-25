// controllers/Notificaciones.controllers.js
const Notificacion = require("../Models/Notificacion");
const NotificacionService = require("../Services/NotificacionesService.js");
const notificacionService = new NotificacionService();

const obtenerNotificaciones = async (req, res) => {
  try {
    return res.status(501).json({ message: "Not implemented: obtenerNotificaciones" });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const obtenerNotificacionPorId = async (req, res) => {
  try {
    const { id } = req.params;
    return res.status(200).json(await notificacionService.getNotificacionId(id));
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const crearNotificacion = async (req, res) => {
  try {
    const datos = req.body;
    await notificacionService.creacionNotificacion(datos);
    return res.status(201).json({ message: "Not implemented: crearNotificacion" });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const actualizarNotificacion = async (req, res) => {
  try {
    const { id } = req.params;
    const datos = req.body;
    return res.status(501).json({ message: "Not implemented: actualizarNotificacion", id });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const eliminarNotificacion = async (req, res) => {
  try {
    const { id } = req.params;
    return res.status(501).json({ message: "Not implemented: eliminarNotificacion", id });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

module.exports = {
  obtenerNotificaciones,
  obtenerNotificacionPorId,
  crearNotificacion,
  actualizarNotificacion,
  eliminarNotificacion,
};
