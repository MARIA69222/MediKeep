// Importamos los controladores individuales
const usuarioController = require('./Usuario.controller');
const medicamentoController = require('./Medicamento.controller');
const historialController = require('./Historial.controller');
const notificacionController = require('./Notificacion.controller');

module.exports = {
  usuarioController,
  medicamentoController,
  historialController,
  notificacionController
};
