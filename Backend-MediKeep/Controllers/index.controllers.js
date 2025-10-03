// Importamos los controladores individuales
const usuarioController = require('./Usuario.controller');
const medicamentoController = require('./Medicamento.controller');
const historialController = require('./Historial.controller');


module.exports = {
  usuarioController,
  medicamentoController,
  historialController
};
