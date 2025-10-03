const express = require('express');
const routes = express.Router();

// Importamos las funciones del controlador de usuarios
const {
  obtenerUsuarios,
  obtenerUsuarioPorId,
  crearUsuario,
  actualizarUsuario,
  eliminarUsuario,
  autenticar,
  obtenerUsuarioPorCorreo
} = require('../Controllers/Usuario.controllers');

// Definimos las rutas HTTP y las conectamos al controlador
routes.get('/', obtenerUsuarios);            // GET /usuarios
routes.get('/:id', obtenerUsuarioPorId);     // GET /usuarios/:id
routes.post('/', crearUsuario);              // POST /usuarios
routes.put('/:id', actualizarUsuario);       // PUT /usuarios/:id
routes.delete('/:id', eliminarUsuario);  
routes.post('/login',autenticar);   
routes.post('/correo', obtenerUsuarioPorCorreo); // GET /usuarios/correo/:correo 

module.exports = routes;
