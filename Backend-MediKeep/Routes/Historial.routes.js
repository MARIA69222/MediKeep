const express = require('express');
const router = express.Router();

// Importamos las funciones del controlador de historial
const {
  obtenerHistoriales,
  obtenerHistorialPorId,
  crearHistorial,
  actualizarHistorial,
  eliminarHistorial
} = require('../Controllers/Historial.controllers');

// Rutas para historial
router.get('/', obtenerHistoriales);               // Obtener todos los historiales
router.get('/:id', obtenerHistorialPorId);       // Obtener un historial por ID
router.post('/', crearHistorial);                // Crear un nuevo historial
router.put('/:id', actualizarHistorial);         // Actualizar un historial existente
router.delete('/:id', eliminarHistorial);        // Eliminar un historial

module.exports = router;