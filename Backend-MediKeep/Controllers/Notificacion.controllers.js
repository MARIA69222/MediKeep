const Notificacion = require("../Models/Notificacion");
const NotificacionService = require("../Services/NotificacionesService");
const notificacionService = new NotificacionService();

const obtenerNotificaciones = async (req, res) => {
  try {
    return res.status(200).json(await notificacionService.getNotificaciones());
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
    const nuevaNotificacion = Notificacion.fromJson(req.body);
    return res.status(201).json(await notificacionService.creacionNotificacion(nuevaNotificacion));
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const actualizarNotificacion = async (req, res) => {
  try {
    const { id } = req.params;
    const datos = req.body;
    await notificacionService.actualizarNotificacion(id, datos);
    return res.status(200).json({ message: "Notificación actualizada", id });
  } catch (error) {
    return res.status(500).json({ message: "Error interno", error: error.message });
  }
};

const eliminarNotificacion = async (req, res) => {
  try {
    const { id } = req.params;
    await notificacionService.eliminarNotificacion(id);
    return res.status(200).json({ message: "Notificación eliminada", id });
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
