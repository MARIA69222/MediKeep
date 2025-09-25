const express = require('express');
const router = express.Router();

// Importamos las funciones del controlador de medicamentos
const {
  obtenerMedicamentos,
  obtenerMedicamentoPorId,
  crearMedicamento,
  actualizarMedicamento,
  eliminarMedicamento
} = require('../Controllers/Medicamentos.controllers');

// Rutas para medicamentos
router.get('/', obtenerMedicamentos);               // Obtener todos los medicamentos
router.get('/:id', obtenerMedicamentoPorId);        // Obtener un medicamento por ID
router.post('/', crearMedicamento);                 // Crear un nuevo medicamento
router.put('/:id', actualizarMedicamento);          // Actualizar un medicamento existente
router.delete('/:id', eliminarMedicamento);         // Eliminar un medicamento

module.exports = router;

