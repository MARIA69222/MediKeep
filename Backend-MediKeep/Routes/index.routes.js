const express = require('express');
const routes = express.Router();

// Importamos cada archivo de rutas
const usuariosRoutes = require('./Usuarios.routes');
//const medicamentosRoutes = require('./Medicamentos.routes');
const historialRoutes = require('./Historial.routes');
const notificacionesRoutes = require('./Notificaciones.routes');

// Definimos los prefijos para cada grupo de rutas
routes.use('/usuarios', usuariosRoutes);
//routes.use('/medicamentos', medicamentosRoutes);
routes.use('/historial', historialRoutes);
routes.use('/notificaciones', notificacionesRoutes);

module.exports = routes;
