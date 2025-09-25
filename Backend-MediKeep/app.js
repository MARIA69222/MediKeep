const express = require("express");
const app = express();
const port = 3001;
const rutas = require("./Routes/index.routes.js");

// middleware primero
app.use(express.json());

// rutas
app.use("/api", rutas);

// activar el servidor
app.listen(port, () => console.log(`Servidor corriendo en el puerto ${port}`));
