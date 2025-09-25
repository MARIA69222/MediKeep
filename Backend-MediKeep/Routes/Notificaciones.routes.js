// routes/Notificaciones.routes.js
const express = require('express');
const router = express.Router();

// Importamos las funciones del controlador de notificaciones
const {
  obtenerNotificaciones,
  obtenerNotificacionPorId,
  crearNotificacion,
  actualizarNotificacion,
  eliminarNotificacion
} = require('../Controllers/Notificacion.controllers.js');

// Rutas para notificaciones
router.get('/', obtenerNotificaciones);              // Obtener todas las notificaciones
router.get('/:id', obtenerNotificacionPorId);       // Obtener una notificación por ID
router.post('/', crearNotificacion);                // Crear una nueva notificación
router.put('/:id', actualizarNotificacion);         // Actualizar una notificación existente
router.delete('/:id', eliminarNotificacion);        // Eliminar una notificación

module.exports = router;


