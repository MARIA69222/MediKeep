const express = require('express');
const routes = express.Router();

// Importamos cada archivo de rutas
const usuariosRoutes = require('./Usuarios.routes');
const medicamentosRoutes = require('./Medicamentos.routes');
const historialRoutes = require('./Historial.routes');



// Definimos los prefijos para cada grupo de rutas
routes.use('/usuario', usuariosRoutes);
routes.use('/medicamento', medicamentosRoutes);
routes.use('/historial', historialRoutes);


module.exports = routes;
